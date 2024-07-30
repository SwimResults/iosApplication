//
//  EventListInfoModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 27.07.24.
//

import Foundation

struct EventListInfoModel: Codable, Hashable {
    var events: [EventListInfoEventModel]
}

struct EventListInfoEventModel: Codable, Hashable {
    var eventNumber: Int
    var amount: Int
    var firstHeat: HeatModel?
}
