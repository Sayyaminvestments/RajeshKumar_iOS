//
//  SMAudioCountModel.swift
//  VoiceRecording
//
//  Created by Sayyam on 19/04/23.
//

import Foundation
struct SMAudioCountModel: Decodable {
    var error_no: Int?
    var error_message: String?
    var region: String?
    var data: ResData?
}
struct ResData: Decodable {
    var upload_total: Int?
    var use_total: Int?
}
