//
//  Config.swift
//  VoiceRecording
//
//  Created by Sayyam on 17/04/23.
//

import Foundation
import MobileCoreServices
import CFNetwork
import UIKit

#if DEBUG
    /************************
     //MARK:- DEBUG MODE
     *************************/
    let API_BASE_URL_Test  =  "https://apptest.voicingrecording.com"
    
#else
    /************************
     //MARK:- RELEASE MODE
     *************************/
    let API_BASE_URL  = "https://app.voicingrecording.com"
   
    
#endif

//MARK: User API
let loigIn_API = API_BASE_URL_Test + "/api/userLogin"
let logOut_API = API_BASE_URL_Test + "/api/userLogout"
let userAudioCount_API = API_BASE_URL_Test + "/api/getUserAudioCount"
let sentanceList_API = API_BASE_URL_Test + "/api/getSentenceList"
let addAudio_API = API_BASE_URL_Test + "/api/addAudio"

 
