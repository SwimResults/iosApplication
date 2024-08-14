//
//  MainViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import Foundation

enum SheetMode {
    case none, live, meetingSelection
}

@MainActor
final class MainViewModel: ObservableObject {
    @Published var currentMeeting: CurrentMeeting?
    @Published var fetching = false
    
    @Published var sheetMode: SheetMode = .none
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
    }
    
    func fetchMeeting(_ meetId: String, silent: Bool = false) async {
        do {
            if (!silent) {
                fetching = true
            }
            let meeting = try await getMeetingByMeetId(meetId)
            print("restored meeting " + meetId + " from AppStorage")
            
            currentMeeting?.meeting = meeting
            
            if (currentMeeting?.meetingId != meeting.meetId) {
                currentMeeting?.meetingId = meeting.meetId
            }
            
        } catch {
            
        }
        if (!silent) {
            fetching = false
        }
    }
}
