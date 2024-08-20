//
//  StartListView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import SwiftUI

struct StartListView: View {
    @ObservedObject private var viewModel = StartListViewModel()
    
    var starts: [StartModel]?
    var config: StartListConfig = StartListConfig()
    var fetching: Bool
    
    var body: some View {
        VStack {
            List {
                if (starts != nil) {
                    ForEach(starts!, id: \.self) {start in
                            NavigationLink(destination: StartView(startId: start._id)) {
                                VStack {
                                    Text("W: \(String(start.event ?? 0)), L: \(String(start.heat?.number ?? 0)), B: \(String(start.lane ?? 0))")
                                    Text(start.athleteName ?? "")
                                    Text(start.athleteTeamName ?? "")
                                        .font(.caption)
                                }
                                
                            }
                    }
                }
            }
            .overlay {
                if fetching {
                    SpinnerView()
                } else {
                    if (starts == nil) {
                        ContentUnavailableView {
                            Label("Keine Starts", systemImage: "flag.fill")
                        } description: {
                            Text("Die Starts konnten nicht geladen werden.")
                        }
                    } else if (starts!.isEmpty) {
                        ContentUnavailableView {
                            Label("Keine Starts", systemImage: "flag.fill")
                        } description: {
                            Text("Es wurden keine Starts gefunden.")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    
    NavigationStack {
        EventView(meetingId: "IESC23", eventNumber: 10)
    }
    //StartListView(starts: [], fetching: false)
}
