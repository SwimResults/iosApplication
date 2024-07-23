//
//  StartViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 22.07.24.
//

import Foundation

@MainActor
final class StartViewModel: ObservableObject {
    @Published var start: StartModel?
    @Published var meetingEvent: EventModel?
    
    @Published var fetching = false
    @Published var fetchingEvent = false
    
    public var startId: String?
    
    func fetchStart() async {
        if (startId == nil) {
            return
        }
        
        fetching = true
        do {
            let start = try await getStartById(startId!)
            
            self.start = start
            
            fetching = false
            
            await fetchEventForStart(start)
        } catch {
            print(error)
            fetching = false
        }
    }
    
    func fetchEventForStart(_ start: StartModel) async {
        fetchingEvent = true
        do {
            let event = try await getEventByMeetingAndNumber(start.meeting, start.event!)
            
            self.meetingEvent = event
            
            fetchingEvent = false
        } catch {
            print(error)
            fetchingEvent = false
        }
    }
}


