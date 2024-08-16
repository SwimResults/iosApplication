//
//  LocationModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 16.08.24.
//

import Foundation

struct LocationModel: Codable, Hashable {
    var _id: String
    var street: String?
    var number: String?
    var city: String?
    var postalCode: String?
    var name: String?
    var lanes: Int?
    var firstLane: Int?
    
    func getAddressString() -> String {
        var out = ""
        out += name ?? ""
        out += ", "
        out += street ?? ""
        out += " "
        out += number ?? ""
        out += ", "
        out += postalCode ?? ""
        out += " "
        out += city ?? ""
        return out
    }
}
