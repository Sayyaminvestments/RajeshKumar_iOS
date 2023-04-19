//
//  UserAudioCount.swift
//  VoiceRecording
//
//  Created by Sayyam on 18/04/23.
//

import Foundation
class UserAudioCountManager {
    var resultModel: SMAudioCountModel?
    
    func getAudioCountApiCall(completionHandler: @escaping (SMAudioCountModel?, Error?) -> Void) {
        var parameter = Dictionary<String,Any>()
        guard let url = URL(string: userAudioCount_API) else {
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
            
            if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) {
                debugPrint(responseJSON)
                let decoder = JSONDecoder()
                do {
                    let jsonData = try decoder.decode(SMAudioCountModel.self, from: data)
                    if let error_no = jsonData.error_no, let error_message = jsonData.error_message {
                        if error_no == 0 && error_message == "success" {
                            debugPrint(error_no,error_message)
                            completionHandler(jsonData.self,error)
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
