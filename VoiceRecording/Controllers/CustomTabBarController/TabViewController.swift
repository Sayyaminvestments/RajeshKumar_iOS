//
//  TabViewController.swift
//  VoiceRecording
//
//  Created by Sayyam on 11/04/23.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Speech Record"
        let systemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]
        UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributes, for: .normal)
       
    }
    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()
    }
    
}
