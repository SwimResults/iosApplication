//
//  AthleteModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 13.07.24.
//

import Foundation

struct AthleteModel: Codable, Hashable {
    var _id: String
    var name: String
    var year: Int?
    var gender: String?
    var team: TeamModel?
    
    
    func getGender() -> String {
        if (self.gender == nil) {
            return "-"
        }
        let genderKey = String.LocalizationValue(stringLiteral: "COMMON.GENDER." + self.gender!)
        return String(localized: genderKey)
    }
}
