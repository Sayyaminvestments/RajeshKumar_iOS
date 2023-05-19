//
//  LogoutApi.swift
//  VoiceRecording
//
//  Created by Sayyam on 18/04/23.
//

import Foundation
import UIKit

class LogoutManager: BaseHelper {
    
    func logoutApiCall() {
         
        var parameter = Dictionary<String,Any>()
        guard let url = URL(string: logOut_API) else {
            return
        }
        var request = URLRequest(url: url)
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        if let phone = UserDefaults.SFSDefault(valueForKey: "phoneNumber") as? String,
           let pass = UserDefaults.SFSDefault(valueForKey: "password") as? String,
           let token = UserDefaults.SFSDefault(valueForKey: "token") as? String{
            
            parameter["phone"] = phone
            parameter["password"] = pass
            parameter["token"] = token
           
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
            
            if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                debugPrint(responseJSON)
                if let error_no = responseJSON["error_no"] as? Int {
                    if error_no == 0 {
                        DispatchQueue.main.async {
                            self.showAlertWithBack(title: "", message: "Sucessfully Logout.")
                        }
                    } else if error_no == 11211303 {
                        DispatchQueue.main.async {
                            self.showalert(title: "", message: "The user is not logged in, please try again")
                        }
                    }
                    
                }
                let decoder = JSONDecoder()
                do {
                    let jsonData = try decoder.decode(SMLogoutModel.self, from: data)
                    if let error_no = jsonData.error_no, let error_message = jsonData.error_message {
                        if error_no == 0 && error_message == "success" {
                            UserDefaults.SFSDefault(removeObjectForKey: "phoneNumber")
                            UserDefaults.SFSDefault(removeObjectForKey: "password")
                            UserDefaults.SFSDefault(removeObjectForKey: "token")
                            UserDefaults.SFSDefault(removeObjectForKey: "name")
                            
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
