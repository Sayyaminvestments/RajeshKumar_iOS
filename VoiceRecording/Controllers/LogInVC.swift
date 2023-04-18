//
//  ViewController.swift
//  VoiceRecording
//
//  Created by Sayyam on 11/04/23.
//

import UIKit

class LogInVC: UIViewController {

    // @IBOutlet
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    
    // Variables
    var iconClick = false
    let imageicon = UIImageView()
    
    // View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageicon.image = UIImage(named:"Closeeye.png")
        let contentview = UIView()
        contentview.addSubview(imageicon)

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
        LogInApiCalling()

    }
    
    // Log In API Calling
    func LogInApiCalling() {
        guard let phoneNumber = phoneTextfield.text,
              let password = passwordTextfield.text else {
              return
          }
        guard let url = URL(string: loigIn_API) else {
            return
        }
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          
          let parameters: [String: Any] = [
              "phone":  phoneNumber,
              "password": password
          ]
      request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
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
              
              if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                   //Handle the response JSON
                  let decoder = JSONDecoder()
                  do {
                      let jsonData = try decoder.decode(LogInResultJson.self, from: data)
                      if let error_no = jsonData.error_no, let error_message = jsonData.error_message, let token = jsonData.data?.token {
                          if error_no == 0 && error_message == "success" {
                              DispatchQueue.main.async {
                                  let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
                                  self.navigationController?.pushViewController(tabViewController, animated: true)
                                 
                              }
                             
                              UserDefaults.SFSDefault(setValue: phoneNumber, forKey: "phoneNumber")
                              UserDefaults.SFSDefault(setValue: password, forKey: "password")
                              UserDefaults.SFSDefault(setValue: token, forKey: "token")
                              
                          } else {
                              DispatchQueue.main.async {
                                  self.showSimpleAlert()
                              }
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
    
    // Show Alert
    func showSimpleAlert() {
        let alert = UIAlertController(title: "", message: "Please enter the correct phone number or password.",         preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
       
        self.present(alert, animated: true, completion: nil)
    }
    
}

