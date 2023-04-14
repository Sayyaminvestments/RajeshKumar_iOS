//
//  AccountVC.swift
//  VoiceRecording
//
//  Created by Sayyam on 11/04/23.
//

import UIKit

class AccountVC: UIViewController {

    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var adoptedLabel: UILabel!
    @IBOutlet weak var uploadedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()


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
        
    }
    

}
