//
//  TeamModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 13.07.24.
//

import Foundation

struct TeamModel: Codable, Hashable {
    var _id: String
    var name: String
    var country: String?
    var logoUrl: String?
}
