//
//  HeatMode.swift
//  SwimResults
//
//  Created by Konrad Weiß on 25.05.24.
//

import Foundation

struct HeatModel: Codable, Hashable {
    var _id: String
    var meeting: String?
    var event: Int?
    var number: Int?
    var startEstimation: Date?
    var startDelayEstimation: Date?
    var startAt: Date?
    var finishedAt: Date?
    
    func getStartAtString() -> String? {
        return dateToTimeString(startAt)
    }
    
    func getStartEstimationString() -> String? {
        return dateToTimeString(startEstimation)
    }
    
    func getStartDelayEstimationString() -> String? {
        return dateToTimeString(startDelayEstimation)
    }
    
    func getFinishedAtString() -> String? {
        return dateToTimeString(finishedAt)
    }
    
    func dateToTimeString(_ date: Date?) -> String? {
        if (date == nil) {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date!)
    }
}
