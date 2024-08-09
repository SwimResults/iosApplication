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
    
    @Published var meetingEvent: EventModel?;
    @Published var heats: [Int: [StartModel]]?
    
    public var eventNumber: Int?
    public var meetingId: String?
    
    func fetchEvent() async {
        if (meetingId == nil || eventNumber == nil) {
            return
        }
        
        fetching = true
        do {
            let event = try await getEventByMeetingAndNumber(meetingId!, eventNumber!)
            
            meetingEvent = event
            
            fetching = false
        } catch {
            print(error)
            fetching = false
        }
    }
    
    func fetchStarts() async {
        if (meetingId == nil || eventNumber == nil) {
            return
        }
        
        fetchingStarts = true
        do {
            let starts = try await getStartsByMeetingAndEvent(meetingId!, eventNumber!)
            
            heats = [Int: [StartModel]]()
            
            for start in starts {
                if (start.heat == nil || start.heat!.number == nil) { continue }
                if heats![start.heat!.number!] != nil {
                    heats![start.heat!.number!]!.append(start)
                } else {
                    heats![start.heat!.number!] = [start]
                }
            }
            
            fetchingStarts = false
        } catch {
            print(error)
            fetchingStarts = false
        }
    }
}
