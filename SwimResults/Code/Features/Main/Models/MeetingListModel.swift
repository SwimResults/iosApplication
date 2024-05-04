//
//  MainMeetingListModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import Foundation

struct MeetingListYearModel: Codable, Hashable {
    var year: Int
    var meetings: [MeetingModel]
}
