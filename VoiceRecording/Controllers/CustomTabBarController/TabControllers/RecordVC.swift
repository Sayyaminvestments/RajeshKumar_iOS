//
//  RecordVC.swift
//  VoiceRecording
//
//  Created by Sayyam on 11/04/23.
//

import UIKit

class RecordVC: UIViewController {

    @IBOutlet weak var finishedLineLabel: UILabel!
    @IBOutlet weak var waitingLineLabel: UILabel!
    
    var isHiddenTableView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        waitingLineLabel.isHidden = false
        finishedLineLabel.isHidden = true
    }
    
    
    @IBAction func waitingBtnPressed(_ sender: UIButton) {
        // line hidden
        waitingLineLabel.isHidden = false
        finishedLineLabel.isHidden = true
        
        // remove child view
         removeChild()
        
            // Add child view
            let finishedViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
            addChild(finishedViewController)
            finishedViewController.view.frame = CGRect(x: 20, y: 190, width: 351, height: 624)
            view.addSubview(finishedViewController.view)
            finishedViewController.didMove(toParent: self)
       
        print("Waiting Pressed")
    }
    
    @IBAction func finishedBtnPressed(_ sender: UIButton) {
        // Line hidden
        waitingLineLabel.isHidden = true
        finishedLineLabel.isHidden = false
        
        // remove child view
        removeChild()
        
            // add view
            print("Finished pressed")
            let finishedViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
            addChild(finishedViewController)
            finishedViewController.view.frame = CGRect(x: 20, y: 190, width: 351, height: 624)
            view.addSubview(finishedViewController.view)
            finishedViewController.didMove(toParent: self)
        
       
    }
    func removeChild() {
        self.children.forEach {
          $0.willMove(toParent: nil)
          $0.view.removeFromSuperview()
          $0.removeFromParent()
        }
      }

}
