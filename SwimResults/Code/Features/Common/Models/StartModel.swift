//
//  StartModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 25.05.24.
//

import Foundation

struct StartModel: Codable, Hashable {
    var _id: String
    var meeting: String
    var event: Int?
    var heat: HeatModel?
    var lane: Int?
    var isRelay: Bool? // TODO: Check if bool values can be non-undefined (omit ?)
    var athlete: String?
    var athleteName: String?
    var athleteAlias: String?
    var athleteYear: Int?
    var athleteTeam: String?
    var athleteTeamName: String?
    var rank: Int?
    var points: Int?
    var certified: Bool?
    var results: [ResultModel]
    var disqualification: DisqualificationModel?
    var addedAt: Date?
    var updatedAt: Date?
    
    func hasDisqualification() -> Bool {
        return (disqualification != nil && Int(disqualification!._id) != 0)
    }
}