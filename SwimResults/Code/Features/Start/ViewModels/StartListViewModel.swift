//
//  StartListViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import Foundation

@MainActor
final class StartListViewModel: ObservableObject {
    @Published var fetching = false
    @Published var starts: [StartModel] = []
    
    init() {
        //var heat: HeatModel = HeatModel(_id: "", meeting: "IESC23", event: 3, number: 5)
        
        //var start1: StartModel = StartModel(_id: "", meeting: "IESC23", event: 3, heat: heat, lane: 1, isRelay: false, athlete: "", athleteMeetingId: 1, athleteName: "Tom Klüger", athleteAlias: "tomklueger", athleteYear: 2004, athleteTeam: "", athleteTeamName: "Chemnitzer SSV", rank: nil, points: nil, certified: false, results: [], disqualification: nil, addedAt: nil, updatedAt: nil)
        
        //var start2: StartModel = StartModel(_id: "", meeting: "IESC23", event: 3, heat: heat, lane: 2, isRelay: false, athlete: "", athleteMeetingId: 1, athleteName: "Simon Meier", athleteAlias: "simonmeier", athleteYear: 2005, athleteTeam: "", athleteTeamName: "Chemnitzer SSV", rank: nil, points: nil, certified: false, results: [], disqualification: nil, addedAt: nil, updatedAt: nil)
        
        //var start3: StartModel = StartModel(_id: "", meeting: "IESC23", event: 3, heat: heat, lane: 3, isRelay: false, athlete: "", athleteMeetingId: 1, athleteName: "Karl Karlovitz", athleteAlias: "karlkarlovitz", athleteYear: 2005, athleteTeam: "", athleteTeamName: "TJV Meinsen", rank: nil, points: nil, certified: false, results: [], disqualification: nil, addedAt: nil, updatedAt: nil)
        
        //var start4: StartModel = StartModel(_id: "", meeting: "IESC23", event: 3, heat: heat, lane: 4, isRelay: false, athlete: "", athleteMeetingId: 1, athleteName: "Omar Margot", athleteAlias: "omarmargot", athleteYear: 2004, athleteTeam: "", athleteTeamName: "TSV 1919 Augsburg e.V.", rank: nil, points: nil, certified: false, results: [], disqualification: nil, addedAt: nil, updatedAt: nil)
        
        //self.starts = [start1, start2, start3, start4]
    }
}
