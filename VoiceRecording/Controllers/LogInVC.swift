//
//  ViewController.swift
//  VoiceRecording
//
//  Created by Sayyam on 11/04/23.
//

import UIKit

class LogInVC: BaseHelper {

    // @IBOutlet
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var eyeButton: UIButton!
    
    // Variables
    var iconClick = true
    
    // View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0.0, y: 50, width: 340, height: 0.3)
        bottomLine1.backgroundColor = UIColor.lightGray.cgColor
        phoneTextfield.borderStyle = UITextField.BorderStyle.none
        phoneTextfield.layer.addSublayer(bottomLine1)
        
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0.0, y: 50, width: 340, height: 0.3)
        bottomLine2.backgroundColor = UIColor.lightGray.cgColor
        passwordTextfield.borderStyle = UITextField.BorderStyle.none
        passwordTextfield.layer.addSublayer(bottomLine2)
    }
    
    @IBAction func eyeButtonPressed(_ sender: UIButton) {
        if iconClick
        {
            iconClick = false
            eyeButton.setImage(UIImage(named: "Openeye.png"), for: .normal)
            passwordTextfield.isSecureTextEntry = false
        }
        else
        {
            iconClick = true
            eyeButton.setImage(UIImage(named: "Closeeye.png"), for: .normal)
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
                  print(responseJSON)
                  if let error_no = responseJSON["error_no"] as? Int {
                      if error_no == 11511001 {
                          DispatchQueue.main.async {
                              self.showalert(title: "", message: "Please enter the correct phone number or password.")
                          }
                      }
                  }
                  let decoder = JSONDecoder()
                  do {
                      let jsonData = try decoder.decode(LogInResultJson.self, from: data)
                      if let error_no = jsonData.error_no, let error_message = jsonData.error_message, let token = jsonData.data?.token, let name = jsonData.data?.name {
                          if error_no == 0 && error_message == "success" {
                              DispatchQueue.main.async {
                                  let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
                                  self.navigationController?.pushViewController(tabViewController, animated: true)
                                  self.passwordTextfield.text = ""
                                  self.phoneTextfield.text = ""
                                  
                                 
                              }
                            
                              UserDefaults.SFSDefault(setValue: phoneNumber, forKey: "phoneNumber")
                              UserDefaults.SFSDefault(setValue: password, forKey: "password")
                              UserDefaults.SFSDefault(setValue: token, forKey: "token")
                              UserDefaults.SFSDefault(setValue: name, forKey: "name")
                              
                              
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

