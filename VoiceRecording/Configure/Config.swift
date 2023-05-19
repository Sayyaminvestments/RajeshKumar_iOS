//
//  Config.swift
//  VoiceRecording
//
//  Created by Sayyam on 17/04/23.
//

import Foundation

#if DEBUG
    /************************
     //MARK:- DEBUG MODE
     *************************/
    let API_BASE_URL  =  "https://apptest.voicingrecording.com"

    
#else
    /************************
     //MARK:- RELEASE MODE
     *************************/
    let API_BASE_URL  = "https://app.voicingrecording.com"
   
    
#endif

//MARK: User API
let loigIn_API = API_BASE_URL + "/api/userLogin"
let logOut_API = API_BASE_URL + "/api/userLogout"
let userAudioCount_API = API_BASE_URL + "/api/getUserAudioCount"
let sentanceList_API = API_BASE_URL + "/api/getSentenceList"
let addAudio_API = API_BASE_URL + "/api/addAudio"

 
