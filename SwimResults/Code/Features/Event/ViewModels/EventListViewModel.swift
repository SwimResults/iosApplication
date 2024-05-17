//
//  EventListViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 08.05.24.
//

import Foundation

@MainActor
final class EventListViewModel: ObservableObject {
    @Published var parts: [MeetingPartModel] = []
    @Published var fetching = false
    
    var currentMeeting: CurrentMeeting?
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
      }
    
    func fetchEventParts() async {
        if (currentMeeting!.meeting == nil) {
            return
        }
        
        fetching = true
        do {
            let parts = try await getEventsAsPartsByMeetId(currentMeeting!.meeting!.meetId)
            
            self.parts = parts
            
            fetching = false
        } catch {
            print(error)
            fetching = false
        }
    }
}
