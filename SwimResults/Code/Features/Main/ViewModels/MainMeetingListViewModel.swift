//
//  MainMeetingListViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import Foundation

@MainActor
final class MainMeetingListViewModel: ObservableObject {
    @Published var meetingYearList: [MeetingListYearModel] = []
    @Published var fetching = false
    
    func fetchMeetings() async {
        fetching = true
        do {
            var meetingYears = [Int: [MeetingModel]]()
            
            let meetings = try await getMeetings()
            for meeting in meetings {
                let year = meeting.getYear()
                if (meetingYears[year] == nil) {
                    meetingYears[year] = []
                }
                meetingYears[year]?.append(meeting)
            }
            
            let meetingList = meetingYears
                .keys
                .sorted()
                .reversed()
                .map{MeetingListYearModel(year: $0, meetings: meetingYears[$0]!)}
            
            self.meetingYearList.removeAll()
            self.meetingYearList.append(contentsOf: meetingList)
            
            fetching = false
        } catch {
            print(error)
            fetching = false
        }
    }
}
