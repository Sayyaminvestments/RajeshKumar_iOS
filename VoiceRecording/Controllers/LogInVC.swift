//
//  ViewController.swift
//  VoiceRecording
//
//  Created by Sayyam on 11/04/23.
//

import UIKit

class LogInVC: UIViewController {

    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    
    var iconClick = false
    let imageicon = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //passwordTextfield.delegate = self
        imageicon.image = UIImage(named:"Closeeye.png")
        let contentview = UIView()
        contentview.addSubview(imageicon)
        //Accounttextfield.clearButtonMode = .whileEditing

        contentview.frame = CGRect(x: 0, y: 0, width: UIImage(named: "Closeeye.png")!.size.width, height: UIImage(named: "Closeeye.png")!.size.height)
        imageicon.frame = CGRect(x: -30, y: 0, width: UIImage(named: "Closeeye.png")!.size.width, height: UIImage(named: "Closeeye.png")!.size.height)
        
        passwordTextfield.rightView = contentview
        passwordTextfield.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:            #selector(imageTapped(tapGestureRecognizer:)))
        imageicon.isUserInteractionEnabled = true
        imageicon.addGestureRecognizer(tapGestureRecognizer)
        
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0.0, y: 50, width: 360, height: 0.3)
        bottomLine1.backgroundColor = UIColor.lightGray.cgColor
        phoneTextfield.borderStyle = UITextField.BorderStyle.none
        phoneTextfield.layer.addSublayer(bottomLine1)
        
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0.0, y: 50, width: 360, height: 0.3)
        bottomLine2.backgroundColor = UIColor.lightGray.cgColor
        passwordTextfield.borderStyle = UITextField.BorderStyle.none
        passwordTextfield.layer.addSublayer(bottomLine2)
    }
    @objc func imageTapped(tapGestureRecognizer:UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if iconClick
        {
            iconClick = false
            tappedImage.image = UIImage(named:"Openeye.png")
            passwordTextfield.isSecureTextEntry = false
        }
        else
        {
            iconClick = true
            tappedImage.image = UIImage(named:"Closeeye.png")
            passwordTextfield.isSecureTextEntry = true
        }
    }
    
    @IBAction func logInpressed(_ sender: UIButton) {
        let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        self.navigationController?.pushViewController(tabViewController, animated: true)
    }
    
}

