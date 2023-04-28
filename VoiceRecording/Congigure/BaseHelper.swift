//
//  BaseHelperViewController.swift
//  VoiceRecording
//
//  Created by Sayyam on 20/04/23.
//

import UIKit
import Foundation

class BaseHelper: UIViewController {
    
    
    //var activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x:105, y: 250, width: 100, height: 150), type: .cubeTransition, color: UIColor.hallaColor(), padding: 20)
    var indicatorView = UIActivityIndicatorView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
         
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func activityIndicator(style: UIActivityIndicatorView.Style = .medium,
                                       frame: CGRect? = nil,
                                       center: CGPoint? = nil) -> UIActivityIndicatorView {
        
        // 2
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        
        // 3
        if let frame = frame {
            activityIndicatorView.frame = frame
        }
        
        // 4
        if let center = center {
            activityIndicatorView.center = center
        }
        
        // 5
        return activityIndicatorView
    }
    func stopLoader ()
    {
        
        self.indicatorView.stopAnimating()
        indicatorView.removeFromSuperview()
    }
    func startLoader ()
    {
        indicatorView = self.activityIndicator(style: .medium,
                                               center: self.view.center)
      
       self.view.addSubview(indicatorView)
        self.indicatorView.startAnimating()
    }

    func showalert (title: String,message : String)
    {
       
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
           }
    }
//    func getTopMostViewController() -> UIViewController? {
//        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
//
//        while let presentedViewController = topMostViewController?.presentedViewController {
//            topMostViewController = presentedViewController
//        }
//
//        return topMostViewController
//    }
    func showAlertWithBack (title: String,message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            self.tabBarController?.navigationController?.popViewController(animated: true)
            print("Handle Ok logic here")
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

}
