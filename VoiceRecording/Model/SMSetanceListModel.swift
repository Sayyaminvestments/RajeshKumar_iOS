//
//  SMSetanceListModel.swift
//  VoiceRecording
//
//  Created by Sayyam on 18/04/23.
//

import Foundation
struct SMSetanceListModel: Decodable {
    var error_no: Int?
    var error_message: String?
    var region: String?
    var data: getData?
    
}
struct getData: Decodable {
    var count: Int?
    var list: [ListArray]?
}
struct ListArray: Decodable{
    var category: String?
    var hasAudio: Int?
    var index: Int?
    var sentence_no: String?
    var text: String?
}
