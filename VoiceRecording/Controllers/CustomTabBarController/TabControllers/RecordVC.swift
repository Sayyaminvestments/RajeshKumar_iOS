//
//  RecordVC.swift
//  VoiceRecording
//
//  Created by Sayyam on 11/04/23.
//

import UIKit

class RecordVC: UIViewController {
    
    // IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var finishedLineLabel: UILabel!
    @IBOutlet weak var waitingLineLabel: UILabel!
    
    // view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waitingLineLabel.isHidden = false
        finishedLineLabel.isHidden = true
        
        // for swape for right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        // swape for left
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                addViewControllerForWaiting()
            case .left:
                print("Swiped right")
                addViewControllerForFinished()
                
            default:
                break
            }
        }
    }
    
    @IBAction func waitingBtnPressed(_ sender: UIButton) {
       
        addViewControllerForWaiting()
        
    }
    
    @IBAction func finishedBtnPressed(_ sender: UIButton) {
        
        addViewControllerForFinished()
        
        
    }
    func removeChild() {
        self.children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
    // addViewControllerForWaiting
    func addViewControllerForWaiting() {
        
       
        // line hidden
        waitingLineLabel.isHidden = false
        finishedLineLabel.isHidden = true
        
        // remove child view
        removeChild()
        
        // Add child view
        let waitingViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        addChild(waitingViewController)
        waitingViewController.isWaiting = "waiting"
        waitingViewController.view.frame = CGRect(x: 20, y: 190, width: containerView.frame.width, height: containerView.frame.height)
        view.addSubview(waitingViewController.view)
        waitingViewController.didMove(toParent: self)
    }
    
    // addViewControllerForFinished
    func addViewControllerForFinished() {
       
        // Line hidden
        waitingLineLabel.isHidden = true
        finishedLineLabel.isHidden = false
        
        // remove child view
        removeChild()
        
        // add view
        
        let finishedViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        addChild(finishedViewController)
        finishedViewController.isWaiting = "finished"
        finishedViewController.view.frame = CGRect(x: 20, y: 190, width: containerView.frame.width, height: containerView.frame.height)
        view.addSubview(finishedViewController.view)
        finishedViewController.didMove(toParent: self)
    }
}
