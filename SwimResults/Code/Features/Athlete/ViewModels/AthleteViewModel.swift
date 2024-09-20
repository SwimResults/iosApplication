//
//  AthleteViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 14.07.24.
//

import Foundation

struct StartsDateModel: Hashable, Codable {
    var date: Date?;
    var components: DateComponents
    
    func getDateString() -> String {
        if (date == nil || components.year ?? 0 < 1000) {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(for: date) ?? ""
    }
}

@MainActor
final class AthleteViewModel: ObservableObject {
    @Published var fetching = false
    @Published var fetchingStarts = false
    
    @Published var athlete: AthleteModel?
    
    @Published var starts: [StartModel] = []
    @Published var startsByDay: [StartsDateModel: [StartModel]]?
    
    var currentMeeting: CurrentMeeting?
    var athleteId: String?
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
    }
    
    
    func fetchAthlete() async {
        print("fetching athlete...")
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
        print("fetching starts...")
        if (currentMeeting?.meetingId == nil) {
            return
        }
        
        fetchingStarts = true
        do {
            let starts = try await getStartsByMeetingAndAthlete(currentMeeting!.meetingId!, athleteId!)
            
            self.starts = starts

            startsByDay = Dictionary(grouping: starts) { (entry) -> StartsDateModel in
                let components = Calendar.current.dateComponents([.day, .year, .month], from: entry.heat?.startEstimation ?? Date())
                let d = Calendar.current.date(from: components)
                return StartsDateModel(date: d, components: components)
            }
            
            fetchingStarts = false
        } catch {
            print(error)
            fetchingStarts = false
        }
    }
}
