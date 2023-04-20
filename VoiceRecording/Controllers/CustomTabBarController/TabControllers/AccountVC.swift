//
//  AccountVC.swift
//  VoiceRecording
//
//  Created by Sayyam on 11/04/23.
//

import UIKit

class AccountVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var adoptedLabel: UILabel!
    @IBOutlet weak var uploadedLabel: UILabel!
    
    let objLogoutManager = LogoutManager()
    let objUserAudioCountManager = UserAudioCountManager()
    var audioCountData: ResData?
    let objBaseVC = BaseHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        objUserAudioCountManager.getAudioCountApiCall { resultData, error in
            if let phone = UserDefaults.SFSDefault(valueForKey: "phoneNumber") as? String, let name = UserDefaults.SFSDefault(valueForKey: "name") as? String{
                if let data = resultData?.data {
                    if let uploadTotal = data.upload_total, let useTotal = data.use_total {
                        DispatchQueue.main.async {
                            self.uploadedLabel.text = String(uploadTotal)
                            self.adoptedLabel.text = String(useTotal)
                            self.phoneNoLabel.text = phone
                            self.nameLabel.text = name
                        }
                    }
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.objBaseVC.showalert(title: "", message: "Hello alert")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        objLogoutManager.logoutApiCall()
        
    }
}

