//
//  SMLoginModel.swift
//  VoiceRecording
//
//  Created by Sayyam on 16/04/23.
//

import Foundation
struct LogInResultJson: Codable{
    var error_no: Int?
    var error_message: String?
    var region: String?
    var data: ResponceData?
}
struct ResponceData: Codable {
    var name: String?
    var speaker_no: String?
    var token: String?
}
