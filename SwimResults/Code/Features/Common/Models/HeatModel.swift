//
//  HeatMode.swift
//  SwimResults
//
//  Created by Konrad Weiß on 25.05.24.
//

import Foundation

struct HeatModel: Codable, Hashable {
    var _id: String
    var meeting: String
    var event: Int?
    var number: Int?
    var startEstimation: Date?
    var startDelayEstimation: Date?
    var startAt: Date?
    var finishedAt: Date?
}
