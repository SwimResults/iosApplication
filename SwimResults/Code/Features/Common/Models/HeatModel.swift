//
//  HeatMode.swift
//  SwimResults
//
//  Created by Konrad Weiß on 25.05.24.
//

import Foundation
import SwiftUI

enum DelayType {
    case delayed
    case ahead
    case onTime
    case unknown
    
    var color: Color {
        switch self {
        case .unknown:
            return .gray
        case .onTime:
            return .primary
        case .delayed:
            return .red
        case .ahead:
            return .green
        }
    }
}

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
    
    func getTimeWithNormalisedDate(_ date: Date) -> Date {
        let calendar = Calendar.current
        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        component.year = 2023
        component.month = 1
        component.day = 1
        return calendar.date(from: component)!
    }
    
    func getDelay() -> Double? {
        if (self.startEstimation == nil || self.startDelayEstimation == nil) {
            return nil
        }
        
        let estimation = getTimeWithNormalisedDate(self.startEstimation!)
        let delayEstimation = getTimeWithNormalisedDate(self.startDelayEstimation!)
        
        return delayEstimation.timeIntervalSince1970 - estimation.timeIntervalSince1970
    }
    
    func getDelayType() -> DelayType {
        let delay = getDelay()
        
        if (delay == nil) {
            return .unknown
        }
        if (delay! > 0) {
            return .delayed
        }
        if (delay! == 0) {
            return .onTime
        }
        if (delay! < 0) {
            return .ahead
        }
        
        return .unknown
    }
    
    func isFinished() -> Bool {
        return finishedAt != nil ? finishedAt!.timeIntervalSince1970 > 1000 : false
    }
}
