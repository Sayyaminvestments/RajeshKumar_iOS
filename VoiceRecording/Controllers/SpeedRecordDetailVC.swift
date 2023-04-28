//
//  SpeedRecordDetailVC.swift
//  VoiceRecording
//
//  Created by Sayyam on 12/04/23.
//

import UIKit
import AVFoundation
import AVKit

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

class SpeedRecordDetailVC: BaseHelper {

    @IBOutlet weak var siriWaveFormView: SiriWaveView!
    @IBOutlet weak var titleLabel: UILabel!
   
    var audioBs64 = ""
    var duration: Double = 0.0
   
    var listModel: ListArray?
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        siriVoiceWaveForm()
        title = "Speech Record"
        titleLabel.text = listModel?.text
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Audio is Recording")
                        
                    } else {
                        // failed to record
                        print("Failed to record")
                    }
                }
            }
        } catch {
            // failed to record!
            print("Failed to Record")
        }
    }
    
    @IBAction func startRecordingBtnPressed(_ sender: UIButton) {
        
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    @IBAction func stopRecordingBtnPressed(_ sender: UIButton) {
        
        audioRecorder.pause()
        audioRecorder = nil
    }
    
    @IBAction func playRecordingBtnPressed(_ sender: UIButton) {
        
        if audioPlayer == nil {
            startPlayback()
            audioBs64 = convertM4aToBs64()
            audioDuration()
            
        } else {
            finishPlayback()
            
        }
        
    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
        addAudioSubmit()
//        if audioBs64.isEmpty{
//            DispatchQueue.main.async {
//                self.showalert(title: "", message: "Please read and record following text")
//            }
//        } else {
//            addAudioSubmit()
//        }
        
    }
    // MARK: - Recording

    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        print(audioFilename)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioURL = audioRecorder.url
            print(audioRecorder.url)
            audioRecorder.delegate = self
            audioRecorder.record()
            
           // recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    // Voice Wave
    private func siriVoiceWaveForm() {
        var ampl: CGFloat = 1
        let speed: CGFloat = 0.1

        func modulate() {
        
            ampl = Lerp.lerp(ampl, 1.5, speed)
            self.siriWaveFormView.update(ampl * 5)
        }
        
        _ = Timeout.setInterval(TimeInterval(speed)) {
            DispatchQueue.main.async {
                modulate()
            }
        }
    }
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
    }
    // duration
    func audioDuration() {
        if let url = audioURL {
            let item = AVPlayerItem(url: url)
            duration = Double(item.asset.duration.value) / Double(item.asset.duration.timescale)
            print(duration)
        }
       
    }
    // MARK: - Convert m4a to wav
    func convertM4aToBs64() -> String{
        
        var audioString = ""
        if let url = audioURL {
            if let audioData =  try? Data(contentsOf: url) {
                let encodedString = audioData.base64EncodedString()

                audioString = encodedString
                print(audioString)
               
            }
        }
          return audioString
            //"AAAAGGZ0eXBtcDQyAAAAAG1wNDJpc29t"
    }
    // MARK: - Playback
    
    func startPlayback() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer.delegate = self
            audioPlayer.play()
           // playButton.setTitle("Stop Playback", for: .normal)
        } catch {
           // playButton.isHidden = true
            // unable to play recording!
            print("Unable to play recording")
        }
    }
    
    func finishPlayback() {
        audioPlayer = nil
        //playButton.setTitle("Play Your Recording", for: .normal)
    }
    func addAudioSubmit() {
        var parameter = Dictionary<String,Any>()
        guard let url = URL(string: addAudio_API) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        if let phone = UserDefaults.SFSDefault(valueForKey: "phoneNumber") as? String,
           let pass = UserDefaults.SFSDefault(valueForKey: "password") as? String,
           let token = UserDefaults.SFSDefault(valueForKey: "token") as? String{
            
            parameter["phone"] = phone
            parameter["password"] = pass
            parameter["token"] = token
            parameter["file"] = audioBs64
            parameter["file_name"] = listModel?.sentence_no
            parameter["duration"] = duration
            parameter["sentence_no"] = listModel?.sentence_no
            parameter["audio_upload_time"] = Date().millisecondsSince1970
            parameter["platform"] = "ios"
            debugPrint(parameter)
            
        }
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: [])
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                print("Status code: \(response.statusCode)")
                return
            }
            
            if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) {
                debugPrint(responseJSON)
                let decoder = JSONDecoder()
                do {
                    let jsonData = try decoder.decode(SMSetanceListModel.self, from: data)
                    if let error_no = jsonData.error_no, let error_message = jsonData.error_message {
                        if error_no == 0 && error_message == "success" {
                            debugPrint(error_no,error_message)
                            
                        } else {
                            
                            print("Please enter the correct phone number or password.")
                        }
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

extension SpeedRecordDetailVC: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
}

extension SpeedRecordDetailVC: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        finishPlayback()
    }
    
}

