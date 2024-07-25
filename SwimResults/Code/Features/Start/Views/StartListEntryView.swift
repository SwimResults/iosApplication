//
//  StartListEntryView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 25.07.24.
//

import SwiftUI

struct StartListEntryView: View {
    var start: StartModel
    var config: StartListConfig = StartListConfig()
    
    var body: some View {
        NavigationLink(destination: StartView(startId: start._id)) {
            VStack(alignment: .leading) {
                Text("W: \(String(start.event ?? 0)), L: \(String(start.heat?.number ?? 0)), B: \(String(start.lane ?? 0))")
                    .bold()
                Text(start.athleteName ?? "")
                Text(start.athleteTeamName ?? "")
                    .font(.caption)
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        List {
            StartListEntryView(
                start: StartModel(
                    _id: "65719d4071d6e4857d2a8cb7",
                    meeting: "IESC23",
                    event: 30,
                    heat: HeatModel(
                        _id: "65719d3d71d6e4857d2a8cb5",
                        meeting: "IESC23",
                        event: 13,
                        number: 5
                    ),
                    lane: 2,
                    isRelay: false,
                    athlete: "64f097ffee541495c132ee51",
                    athleteName: "Konrad Weiß",
                    athleteAlias: "konradweiss",
                    athleteYear: 2002,
                    athleteTeam: "64f09716ee541495c132ed66",
                    athleteTeamName: "ST Erzgebirge",
                    rank: 4,
                    points: 100,
                    certified: false,
                    results: [],
                    disqualification: DisqualificationModel(
                        _id: "0"
                    )
                )
            )
        }
    }
}
