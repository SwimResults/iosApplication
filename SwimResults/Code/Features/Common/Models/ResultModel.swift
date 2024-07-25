//
//  ResultModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 13.06.24.
//

import Foundation

struct ResultModel: Codable, Hashable {
    var time: Int?
    var resultType: String?
    var lapMeters: Int?
    var addedAt: Date?
}
