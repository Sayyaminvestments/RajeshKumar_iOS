//
//  SentanceListApi.swift
//  VoiceRecording
//
//  Created by Sayyam on 18/04/23.
//

import Foundation
class SentanceListManger {
    var resultModel: SMSetanceListModel?
    func sentanceListApi(isWaiting: String,pageNo: Int, completionHandler: @escaping (SMSetanceListModel?,Error?)-> Void) {
        var parameter = Dictionary<String,Any>()
        guard let url = URL(string: sentanceList_API) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        if let phone = UserDefaults.SFSDefault(valueForKey: "phoneNumber") as? String,
           let pass = UserDefaults.SFSDefault(valueForKey: "password") as? String,
           let token = UserDefaults.SFSDefault(valueForKey: "token") as? String{
            print(isWaiting)
            parameter["phone"] = phone
            parameter["password"] = pass
            parameter["token"] = token
            parameter["page_number"] = 1
            parameter["page_size"] = pageNo
            parameter["state"] = isWaiting//"waiting"
            parameter["app_version"] = "1.1.0"
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
                    let jsonData = try decoder.decode(SMSetanceListModel.self, from: data)
                    if let error_no = jsonData.error_no, let error_message = jsonData.error_message,let list = jsonData.data?.list {
                        if error_no == 0 && error_message == "success" {
                            debugPrint(error_no,error_message)
                            completionHandler(jsonData.self,error)
                            
                        } else {
                            
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
    
}
