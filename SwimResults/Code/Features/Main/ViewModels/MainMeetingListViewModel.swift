//
//  MainMeetingListViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import Foundation

final class MainMeetingListViewModel: ObservableObject {
    @Published var meetingYearList: [MeetingListYearModel] = []
    
    func fetchMeetings() async {
        do {
            var meetingYears = [Int: MeetingListYearModel]()
            
            let meetings = try await getMeetings()
            for meeting in meetings {
                var year = meeting.getYear()
                meetingYears[year]?.year = year
                meetingYears[year]?.meetings.append(meeting)
            }
            
            let meet = meetingYears
                .keys
                .sorted()
                .map{MeetingListYearModel(year: $0, meetings: meetingYears[$0]?.meetings!)}
        } catch {
            print(error)
        }
    }
}
