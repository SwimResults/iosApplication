//
//  MeetingModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import Foundation

struct MeetingModel: Codable, Hashable {
    
    var meetId: String
    var dateStart: Date
    var dateEnd: Date
    var iteration: Int?
    var state: String
    var series: MeetingSeriesModel
    var unpublished: Bool?
    var layout: MeetingLayoutModel?
    var organizerId: String?
    
    func getYear() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: dateStart)
        return Int(yearString) ?? 0
    }
    
    func getFullName() -> String {
        var number = ""
        if (iteration != nil) {
            number = String(iteration!) + ". "
        }
        return number + series.nameFull + " " + String(getYear())
    }
    
    
    func getShortName() -> String {
        var number = ""
        if (iteration != nil) {
            number = String(iteration!) + ". "
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: dateStart)
        return number + series.nameShort + " " + yearString
    }
    
    func getStartDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: dateStart)
    }
    
    func getEndDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: dateEnd)
    }
}

struct MeetingSeriesModel: Codable, Hashable {
    var nameFull: String
    var nameMedium: String
    var nameShort: String
}

struct MeetingLayoutModel: Codable, Hashable {
    var logoUrl: String?
    var colorSet: ColorSetModel?
}

struct ColorSetModel: Codable, Hashable {
    var primary: String?
    var secondary: String?
}
