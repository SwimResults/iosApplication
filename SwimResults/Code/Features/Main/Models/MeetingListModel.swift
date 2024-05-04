//
//  MainMeetingListModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import Foundation

struct MainMeetingListModel: Codable, Hashable {
    var
}

struct MeetingList

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
