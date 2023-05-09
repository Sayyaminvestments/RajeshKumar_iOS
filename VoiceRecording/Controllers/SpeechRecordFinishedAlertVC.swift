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
    
    // IBOutlet
    @IBOutlet weak var alertView: UIView!
    
    //variables
    var delegate: SpeechRecordDelegate?
    
    // view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.layer.cornerRadius = 11
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view == self.view {
             self.view.removeFromSuperview()
             self.removeFromParent()
        }
    }
    @IBAction func yesBtnPressed(_ sender: UIButton) {
        if self.delegate != nil {
            self.view.removeFromSuperview()
            self.removeFromParent()
            self.delegate?.speechRecordDetailVC()
            
        }
    }
    @IBAction func noBtnPressed(_ sender: UIButton) {
        
        self.view.removeFromSuperview()
        self.removeFromParent()
        
    }
}
