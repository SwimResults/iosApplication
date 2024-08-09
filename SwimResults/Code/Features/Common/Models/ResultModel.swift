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
    
    func getTimeString() -> String {
        if (time == nil || time == 0) {
            return "-"
        }
        
        let time1 = time!/(1000*1000)
        let hours = time1 / (1000 * 60 * 60)
        let allMinutes = time1 / (1000 * 60)
        let minutes = allMinutes - hours * 60
        let allSeconds = time1 / (1000)
        let seconds = allSeconds - allMinutes * 60
        let tinyseconds = (time1 / 10) - allSeconds * 100
        
        var output = ""
        if (hours > 0) {
            output += String(hours)
            output += ":"
            output += String(format: "%02d", minutes)
        } else {
            output += String(minutes)
        }
        output += ":"
        output += String(format: "%02d", seconds)
        output += ","
        output += String(format: "%02d", tinyseconds)
        
        return output
    }
}
