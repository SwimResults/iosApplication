//
//  StartListEntryViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 16.08.24.
//

import Foundation

@MainActor
final class StartListEntryViewModel: ObservableObject {
    @Published var meetingEvent: EventModel?
    
    @Published var fetchingEvent = false
    
    var start: StartModel?
    var config: StartListConfig?
    
    func fetchEventForStart(_ start: StartModel) async {
        // only fetch if event is missing
        if (start.event == nil) { return }
        print("try to fetch event \(start.event!)")
        if (meetingEvent != nil) {
            print("found in cache, do not send request")
            return
        }
        print("not in cache, fetching...")
        
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


