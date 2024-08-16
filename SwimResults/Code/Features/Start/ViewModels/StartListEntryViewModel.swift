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


