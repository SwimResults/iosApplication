//
//  EventViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import Foundation

final class EventViewModel: ObservableObject {
    @Published var fetching = false
    @Published var fetchingStarts = false
    
    @Published var starts: [StartModel]?
    
    var currentMeeting: CurrentMeeting?
    var meetingEvent: EventModel?
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
    }
    
    func fetchStarts() async {
        if (currentMeeting?.meeting?.meetId == nil || meetingEvent == nil) {
            return
        }
        
        fetchingStarts = true
        do {
            let starts = try await getStartsByMeetingAndEvent(currentMeeting!.meeting!.meetId, meetingEvent!.number)
            
            self.starts = starts
            
            fetchingStarts = false
        } catch {
            print(error)
            fetchingStarts = false
        }
    }
}
