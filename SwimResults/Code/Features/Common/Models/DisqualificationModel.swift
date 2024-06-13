//
//  DisqualificationModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 13.06.24.
//

import Foundation

struct DisqualificationModel: Codable, Hashable {
    var _id: String
    var type: String?
    var reason: String?
    var announcementTime: Date?
    var addedAt: Date?
}
