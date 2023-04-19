//
//  SpeedRecordDetailVC.swift
//  VoiceRecording
//
//  Created by Sayyam on 12/04/23.
//

import UIKit

class SpeedRecordDetailVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    var titleName: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = titleName
    }
    
    @IBAction func startRecordingBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func stopRecordingBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func playRecordingBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
        
    }
    
}
