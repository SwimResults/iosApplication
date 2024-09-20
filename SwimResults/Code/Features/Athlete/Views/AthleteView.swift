//
//  AthleteView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 14.07.24.
//

import SwiftUI

struct AthleteView: View {
    @EnvironmentObject var currentMeeting: CurrentMeeting
    
    @StateObject private var viewModel = AthleteViewModel()
    var athleteId: String;
    var athleteName: String;
    
    @State var config: StartListConfig = StartListConfig(showEvent: true, showStyle: true, showHeat: true, showLane: true, showTimes: true, showIcon: true, rankStylesIcon: true)
    
    var body: some View {
        VStack {
            if (viewModel.athlete == nil && !viewModel.fetching) {
                ContentUnavailableView {
                    Label("Kein Sportler", systemImage: "calendar")
                } description: {
                    Text("Der Sportler wurde nicht gefunden.")
                }
            } else {
                List {
                    
                    Section {
                        
                        LabeledContent {
                            Text((viewModel.athlete?.year != nil) ? String((viewModel.athlete?.year)!) : "-")
                        } label: {
                            Label("Jahrgang", systemImage: "calendar")
                        }
                        
                        LabeledContent {
                            Text(viewModel.athlete?.getGender() ?? "-")
                        } label: {
                            Label("Geschlecht", systemImage: "figure.dress.line.vertical.figure")
                        }
                        
                        LabeledContent {
                            Text(viewModel.athlete?.team?.name ?? "-")
                        } label: {
                            Label("Verein", systemImage: "person.2.fill")
                        }
                        
                        LabeledContent {
                            Text(viewModel.athlete?.team?.country ?? "-")
                        } label: {
                            Label("Land", systemImage: "flag.fill")
                        }
                    }
                    
                    if (viewModel.startsByDay != nil) {
                        ForEach(Array(viewModel.startsByDay!.keys).sorted(by: { ($0.date)?.compare($1.date ?? Date()).rawValue ?? 0 < 0 }), id: \.self) {startDay in
                            Section {
                                ForEach(viewModel.startsByDay![startDay]!, id: \.self) {start in
                                    StartListEntryView(start: start, config: $config)
                                }
                            } header: {
                                HStack {
                                    Text("Starts")
                                    Spacer()
                                    Text(startDay.getDateString())
                                }
                            }
                        }
                    }
                }
                .listStyle(.grouped)
                .refreshable {
                    await viewModel.fetchAthlete()
                    await viewModel.fetchStarts()
                }
                .overlay {
                    if (viewModel.fetching && viewModel.athlete == nil) || (viewModel.fetchingStarts && viewModel.starts == []) {
                        SpinnerView()
                    }
                }
            }
        }
        .onAppear {
            viewModel.setup(currentMeeting)
        }
        .task {
            viewModel.athleteId = athleteId
            await viewModel.fetchAthlete()
            await viewModel.fetchStarts()
        }
        .navigationTitle(athleteName)
    }
}

#Preview {
    NavigationStack {
        AthleteView(athleteId: "64f09784ee541495c132ee10", athleteName: "Luca Heidenreich")
            .environmentObject(CurrentMeeting.example())
    }
}
