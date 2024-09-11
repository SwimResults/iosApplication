//
//  AgeGroupModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 10.09.24.
//

import Foundation

struct AgeGroupModel: Codable, Hashable {
    var _id: String
    var meeting: String
    var event: Int?
    //var default: String?
    var gender: String?
    var minAge: String?
    var maxAge: String?
    var ages: [Int]
    var isYear: Bool?
    var name: String?
    var addedAt: Date?
    var updatedAt: Date?
    
    func getGender() -> String {
        if (self.gender == nil) {
            return "-"
        }
        let genderKey = String.LocalizationValue(stringLiteral: "COMMON.GENDER." + self.gender!)
        return String(localized: genderKey)
    }
}
