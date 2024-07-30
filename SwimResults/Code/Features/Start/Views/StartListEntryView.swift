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
                
                if (config.laneAsIcon) {
                    HStack(alignment: .center) {
                        Text("\(start.lane ?? 0)")
                            .frame(width: 30, height: 30)
                            .background(
                                RoundedRectangle(cornerRadius: 6, style: .continuous).fill(Color.blue)
                            )
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .padding([.trailing], 5)
                        VStack(alignment: .leading) {
                            if (config.showEvent) {
                                Text("W: \(String(start.event ?? 0)), L: \(String(start.heat?.number ?? 0))")
                                    .bold()
                            }
                            
                            if (config.showAthlete) {
                                Text(start.athleteName ?? "")
                                    .bold()
                                Text(start.athleteTeamName ?? "")
                                    .font(.caption)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
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
                ),
                config: StartListConfig(
                    showAthlete: true,
                    showEvent: false,
                    showStyle: false,
                    showHeat: false,
                    showLane: false,
                    showTimes: false,
                    showRegistrationTime: false,
                    showResults: false,
                    showResultTime: false,
                    showLapTimes: false,
                    showLapTimesPopup: false,
                    showDisqualification: false,
                    showReactionTime: false,
                    showMostSignificantTime: false,
                    laneAsIcon: true,
                    showIcon: false,
                    flatStyle: false,
                    allLanes: false,
                    rankStylesIcon: false,
                    widgetSize: false
                )
            )
        }
    }
}
