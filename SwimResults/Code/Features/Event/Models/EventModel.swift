//
//  EventModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 08.05.24.
//

import Foundation

struct EventModel: Codable, Hashable {
    var _id: String
    var number: Int
    var distance: Int
    var relayDistance: String?
    var meeting: String
    var gender: String
    var style: StyleModel?
    //var final: EventFinalModel?
    //var part: MeetingPartModel?
    //var finished: Bool?
    //var certified: Bool?
    //var noStartList: Bool?
    //var ordering: Int?
    
    func getEventName() -> String {
        let genderKey = String.LocalizationValue(stringLiteral: "COMMON.GENDER." + self.gender)
        let styleKey = String.LocalizationValue(stringLiteral: "COMMON.STYLE." + (self.style?.name ?? "DEFAULT"))
        return "\((self.relayDistance ?? String(self.distance)))m " + String(localized: styleKey) + " " + String(localized: genderKey)
    }
}

struct StyleModel: Hashable, Codable {
    var _id: String
    var name: String
    var aliases: [String]
    var relay: Bool?
    
}

struct EventFinalModel: Hashable, Codable {
    var isPrelim: Bool?
    var isFinal: Bool?
    var name: String?
}

struct MeetingPartModel: Hashable, Codable {
    var number: Int
    var name: String?
    var events: [EventModel] = []
}

