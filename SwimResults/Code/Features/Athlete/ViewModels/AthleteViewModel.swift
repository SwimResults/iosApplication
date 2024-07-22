//
//  AthleteViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 14.07.24.
//

import Foundation

final class AthleteViewModel: ObservableObject {
    @Published var fetching = false
    @Published var fetchingStarts = false
    
    @Published var athlete: AthleteModel?
    
    @Published var starts: [StartModel] = []
    
    var currentMeeting: CurrentMeeting?
    var athleteId: String?
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
    }
    
    
    func fetchAthlete() async {
        if (athleteId == nil) {
            return
        }
        
        fetching = true
        do {
            let athlete = try await getAthleteById(athleteId!)
            
            self.athlete = athlete
            
            fetching = false
        } catch {
            print(error)
            fetching = false
        }
    }
    
    func fetchStarts() async {
        if (currentMeeting?.meeting?.meetId == nil) {
            return
        }
        
        fetchingStarts = true
        do {
            let starts = try await getStartsByMeetingAndAthlete(currentMeeting!.meeting!.meetId, athleteId!)
            
            self.starts = starts
            
            fetchingStarts = false
        } catch {
            print(error)
            fetchingStarts = false
        }
    }
}
