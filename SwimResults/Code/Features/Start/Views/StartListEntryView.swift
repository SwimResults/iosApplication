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
    
    @StateObject private var viewModel = StartListEntryViewModel()
    
    func getIconColor() -> Color {
        if (config.laneAsIcon) { return .blue }
        if (config.rankStylesIcon) {
            if (start.rank != nil && start.rank != 0) {
                switch start.rank! {
                case 1:
                    return .orange
                case 2:
                    return .gray
                case 3:
                    return .brown
                default:
                    return .blue
                }
            }
        }
        if (start.hasDisqualification()) {
            return .red
        }
        return .blue
    }

    var body: some View {
        NavigationLink(destination: StartView(startId: start._id)) {
            HStack(alignment: .center) {
                if (config.showTimes && start.heat != nil) {
                    VStack {
                        Text(start.heat!.getStartEstimationString() ?? "--:--")
                        Text(start.heat!.getStartDelayEstimationString() ?? "--:--")
                            .foregroundStyle(start.heat!.getDelayType().color)
                    }.frame(width: 36)
                        .font(.caption)
                }
                
                if (config.showIcon) {
                    ZStack {
                        if (config.laneAsIcon) {
                            Text("\(start.lane ?? 0)")
                        } else if (start.rank != nil && start.rank != 0) {
                            Text("\(start.rank!).")
                        } else if (start.hasDisqualification()) {
                            Image(systemName: "circle.slash")
                        } else {
                            Image(systemName: "figure.pool.swim")
                        }
                    }
                    .frame(width: 30, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous).fill(getIconColor())
                    )
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .padding([.trailing], 5)
                }
                VStack(alignment: .leading) {
                    if (config.showEvent) {
                        HStack {
                            Text("Wk \(String(start.event ?? 0))")
                            if (config.showStyle && viewModel.meetingEvent != nil) {
                                Text(viewModel.meetingEvent!.getEventName(skipGender: true))
                            }
                        }
                        .bold()
                        HStack {
                            if (config.showHeat && start.heat != nil && start.heat!.number != nil) {
                                Text("Lauf: \(start.heat!.number!)")
                            }
                            if (config.showLane && start.lane != nil) {
                                Text("Bahn: \(start.lane!)")
                            }
                        }
                        .font(.caption)
                            
                    }
                    
                    if (config.showAthlete) {
                        HStack {
                            Text(start.athleteName ?? "")
                                .bold()
                            if (start.athleteYear != nil) {
                                Text(String(start.athleteYear!))
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                        }
                        if (start.athleteTeamName != nil) {
                            HStack {
                                Text(start.athleteTeamName!)
                            }
                            .font(.caption)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if (config.showRegistrationTime) {
                    Text(start.getResultString(ResultType.registration) ?? "")
                        .foregroundStyle(.gray)
                }
            }
        }
        .task {
            viewModel.config = config
            viewModel.start = start
            await viewModel.fetchEventForStart(start)
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
                    rank: 0,
                    points: 100,
                    certified: false,
                    results: [],
                    disqualification: DisqualificationModel(
                        _id: "0"
                    )
                ),
                config: StartListConfig(
                    // var showAthlete: Bool = false
                    // var showEvent: Bool = false;
                    // var showStyle: Bool = false;
                    // var showHeat: Bool = false;
                    // var showLane: Bool = false;
                    // var showIcon: Bool = false;
                    // var laneAsIcon: Bool = false;
                    // var rankStylesIcon: Bool = false;
                    
                    showAthlete: false,
                    showEvent: true,
                    showStyle: false,
                    showHeat: true,
                    showLane: true,
                    showTimes: true,
                    showRegistrationTime: false,
                    showResults: false,
                    showResultTime: false,
                    showLapTimes: false,
                    showLapTimesPopup: false,
                    showDisqualification: false,
                    showReactionTime: false,
                    showMostSignificantTime: false,
                    laneAsIcon: false,
                    showIcon: true,
                    flatStyle: false,
                    allLanes: false,
                    rankStylesIcon: false,
                    widgetSize: false
                )
            )
        }
    }
}
