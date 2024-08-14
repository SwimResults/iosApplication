//
//  SearchViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 13.07.24.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var athletes: [AthleteModel] = []
    @Published var fetching = false
    
    @Published var searchText = ""
    
    var currentMeeting: CurrentMeeting?
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
      }
    
    func fetchAthletes() async {
        if (currentMeeting!.meetingId == nil) {
            return
        }
        
        fetching = true
        do {
            let athletes = try await getAthletesByMeeting(meetId: currentMeeting!.meetingId!)
            
            self.athletes = athletes
            
            fetching = false
        } catch {
            print(error)
            fetching = false
        }
    }
    
    var filteredAthletes: [AthleteModel] {
        if searchText.isEmpty {
            return athletes
        } else {
            return athletes.filter { $0.name.localizedCaseInsensitiveContains(searchText) || ( ($0.team != nil) && $0.team!.name.localizedCaseInsensitiveContains(searchText)) }
        }
    }
}
