//
//  EventStartResultRequestDto.swift
//  SwimResults
//
//  Created by Konrad Weiß on 10.09.24.
//

import Foundation

struct EventAgeResultModel: Codable, Hashable {
    var ageGroup: AgeGroupModel?
    var starts: [StartModel]
}
