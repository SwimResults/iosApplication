//
//  StartModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 25.05.24.
//

import Foundation

enum ResultType: String {
    case registration = "registration"
    case livetiming = "livetiming_result"
    case reaction = "reaction"
    case result_list = "result_list"
    case lap = "lap"
    
    var priority: Int {
        return switch self {
        case .registration:
            1
        case .livetiming:
            4
        case .reaction:
            2
        case .result_list:
            5
        case .lap:
            3
        }
    }
}

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
    
    func getResult(_ resType: ResultType) -> ResultModel? {
        var time: ResultModel?
        var latest: Date?
        for result in results {
            if (result.resultType == resType.rawValue && result.addedAt != nil) {
                if (latest == nil || latest! < result.addedAt!) {
                    time = result
                    latest = result.addedAt!
                }
            }
        }
        
        return time
    }
    
    func getResultString(_ resType: ResultType) -> String? {
        let result = getResult(resType)
        return result?.getTimeString()
    }
    
    func hasResultType(_ resType: ResultType) -> Bool {
        for result in results {
            if (result.resultType == resType.rawValue) {
                return true
            }
        }
        return false
    }
    
    func getMostSignificantTime() -> ResultModel? {
        var bestType: ResultType = .registration
        var bestLap: Int = 0
        var bestResult: ResultModel?
        
        /// should be limited to a single for loop, thats why no other methods are reused
        for result in results {
            if (result.resultType == nil) {
                continue
            }
            
            var resultType = ResultType(rawValue: result.resultType!)
            if (resultType == nil) {
                continue
            }
            
            if (resultType!.priority > bestType.priority) {
                bestType = resultType!
                
                if (resultType == .lap) {
                    if (result.lapMeters == nil) {
                        continue
                    }
                    if (result.lapMeters! > bestLap) {
                        bestLap = result.lapMeters!
                    } else {
                        continue
                    }
                }
                
                bestResult = result
            }
        }
        
        return bestResult
    }
    
    func getMostSignificantTimeString() -> String? {
        let result = getMostSignificantTime()
        return result?.getTimeString()
    }
    
    func getResultTime() -> ResultModel? {
        var time: ResultModel?
        var latest: Date?
        for result in results {
            if ((result.resultType == ResultType.livetiming.rawValue || result.resultType == ResultType.result_list.rawValue) && result.addedAt != nil) {
                if (latest == nil || latest! < result.addedAt!) {
                    time = result
                    latest = result.addedAt!
                }
            }
        }
        
        return time
    }
    
    func getResultTimeString() -> String? {
        let result = getResultTime()
        return result?.getTimeString()
    }
    
    func getLaps() -> [ResultModel] {
        var laps: [Int:ResultModel] = [Int: ResultModel]()
        for result in results {
            if (result.resultType == ResultType.lap.rawValue && result.addedAt != nil && result.lapMeters != nil) {
                if (laps[result.lapMeters!] == nil || laps[result.lapMeters!]!.addedAt! < result.addedAt!) {
                    laps[result.lapMeters!] = result
                }
            }
        }
        
        return laps.values.sorted {
            $0.lapMeters! < $1.lapMeters!
        }
    }
}
