//
//  EventViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import Foundation

enum EventViewMode: String {
    case starts = "Starts"
    case finish = "Finish"
    case results = "Results"
}

@MainActor
final class EventViewModel: ObservableObject {
    @Published var fetching = false
    @Published var fetchingStarts = false
    
    @Published var meetingEvent: EventModel?;
    @Published var heats: [Int: [StartModel]]?
    
    @Published var viewMode: EventViewMode = .starts
    
    public var eventNumber: Int?
    public var meetingId: String?
    
    func refreshForViewMode() {
        print("refreshing event start list for view: " + viewMode.rawValue)
        switch viewMode {
        case .starts:
            sortByLane()
        case .finish:
            sortByResult()
        case .results:
            break
            //await fetchResults()
        }
    }
    
    func sortByResult() {
        if (heats == nil) {
            return
        }
        for heat in heats! {
            var heatSorted = heat.value.sorted {
                if ($0.hasDisqualification()) {
                    if (!$1.hasDisqualification()) {
                        return false
                    }
                } else {
                    if ($1.hasDisqualification()) {
                        return true
                    }
                }
                return $0.getResultTime()?.time ?? Int.max < $1.getResultTime()?.time ?? Int.max
            }
            
            var rank = 0
            for index in 0..<heatSorted.count {
                if heatSorted[index].hasDisqualification() {
                    continue
                }
                rank += 1
                heatSorted[index].rank = rank
            }
            
            heats![heat.key] = heatSorted
        }
    }
    
    func sortByLane() {
        if (heats == nil) {
            return
        }
        for heat in heats! {
            heats![heat.key] = heat.value.sorted {
                $0.lane ?? 0 < $1.lane ?? 0
            }
        }
    }
    
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
            refreshForViewMode()
            fetchingStarts = false
        } catch {
            print(error)
            fetchingStarts = false
        }
    }
    
    func fetchResults() async {
        if (meetingId == nil || eventNumber == nil) {
            return
        }
        
        fetchingStarts = true
        do {
            let ages = try await getStartsByMeetingAndEventAsResults(meetingId!, eventNumber!)
            
            heats = [Int: [StartModel]]()
            
            for age in ages {
                if (start.heat == nil || start.heat!.number == nil) { continue }
                if heats![start.heat!.number!] != nil {
                    heats![start.heat!.number!]!.append(start)
                } else {
                    heats![start.heat!.number!] = [start]
                }
            }
            refreshForViewMode()
            fetchingStarts = false
        } catch {
            print(error)
            fetchingStarts = false
        }
    }
}
