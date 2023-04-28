//
//  speechRecordFinishedAlertVC.swift
//  VoiceRecording
//
//  Created by Sayyam on 12/04/23.
//

import UIKit

protocol SpeechRecordDelegate {
    func speechRecordDetailVC()
}

class SpeechRecordFinishedAlertVC: UIViewController {
    
    @IBOutlet weak var alertView: UIView!
    
    var delegate: SpeechRecordDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.layer.cornerRadius = 11
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view == self.view {
             self.dismiss(animated: true)
        }
    }
    @IBAction func yesBtnPressed(_ sender: UIButton) {
        if self.delegate != nil {
             dismiss(animated: true) {
                self.delegate?.speechRecordDetailVC()
            }
        }
//        dismiss(animated: true, completion: nil)
//        let controller = self.storyboard!.instantiateViewController(withIdentifier: "SpeedRecordDetailVC") as! SpeedRecordDetailVC
//        controller.modalPresentationStyle = .fullScreen
//        self.present(controller, animated: true)
        
    }
    @IBAction func noBtnPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true)
        
    }
}
