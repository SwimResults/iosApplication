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
    @Published var heatInfo: [Int: EventListInfoEventModel] = [Int: EventListInfoEventModel]()
    @Published var fetching = false
    
    var currentMeeting: CurrentMeeting?
    
    func setup(_ currentMeeting: CurrentMeeting) {
        print("setup currentMeeting in EventListViewModel")
        self.currentMeeting = currentMeeting
      }
    
    func fetchEventParts() async {
        if (currentMeeting!.meetingId == nil) {
            return
        }
        
        fetching = true
        do {
            let parts = try await getEventsAsPartsByMeetId(currentMeeting!.meetingId!)
            
            self.parts = parts
            
            fetching = false
        } catch {
            print(error)
            fetching = false
        }
    }
    
    func fetchHeatInfo() async {
        if (currentMeeting!.meetingId == nil) {
            return
        }
        
        do {
            let info = try await getHeatsByMeetingForEventList(currentMeeting!.meetingId!)
            
            heatInfo.removeAll()
            for eventInfo in info.events {
                heatInfo[eventInfo.eventNumber] = eventInfo
            }
            
        } catch {
            print(error)
        }
    }
}
