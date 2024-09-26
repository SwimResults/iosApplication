//
//  NotificationUserModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 21.09.24.
//

import Foundation


struct NotificationUserModel: Codable, Hashable {
    var _id: String
    var user_id: String?
    var token: String
}

struct NotificationRegisterUserRequestDto: Codable, Hashable {
    var token: String
}
