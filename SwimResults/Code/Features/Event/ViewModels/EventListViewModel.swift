//
//  EventListViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 08.05.24.
//

import Foundation

final class EventListViewModel: ObservableObject {
    @Published var parts: [MeetingPartModel] = []
    @Published var fetching = false
    
    var currentMeeting: CurrentMeeting?
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
      }
    
    func fetchEventParts() {
        if (currentMeeting!.meeting == nil) {
            return
        }
        
        fetching = true
        Task {
            do {
                parts = try await getEventsAsPartsByMeetId(currentMeeting!.meeting!.meetId)
                print(parts)
                fetching = false
            } catch {
                print(error)
                fetching = false
            }
        }
    }
}
