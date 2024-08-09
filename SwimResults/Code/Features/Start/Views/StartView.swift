//
//  StartView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 22.07.24.
//

import SwiftUI

struct StartView: View {
    public var startId: String
    
    @ObservedObject private var viewModel = StartViewModel()
    
    var body: some View {
        VStack {
            if (viewModel.start == nil && viewModel.startId == nil) {
                ContentUnavailableView {
                    Label("Kein Start", systemImage: "calendar")
                } description: {
                    Text("Es ist ein Fehler aufgetreten. Der Start konnte nicht gefunden werden.")
                }
            } else {
                List {
                    if (viewModel.start != nil) {
                        
                        Section("Meldung") {
                            
                            if (viewModel.meetingEvent != nil) {
                                NavigationLink(
                                    destination: EventView(meetingId: viewModel.meetingEvent!.meeting, eventNumber: viewModel.meetingEvent!.number)
                                ) {
                                    HStack {
                                        Text("\(viewModel.meetingEvent!.number)")
                                            .frame(width: 30, height: 30)
                                            .background(
                                                RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Color.blue)
                                            )
                                            .foregroundStyle(.white)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                        VStack {
                                            HStack {
                                                Text(viewModel.meetingEvent!.getEventName())
                                                    .bold()
                                                Spacer()
                                            }
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                            }
                            
                            LabeledContent {
                                Text(String(viewModel.start?.heat?.number ?? 0))
                            } label: {
                                Label("Lauf", systemImage: "list.bullet.rectangle")
                            }
                            
                            LabeledContent {
                                Text(String(viewModel.start?.lane ?? 0))
                            } label: {
                                Label("Bahn", systemImage: "\(viewModel.start?.lane ?? 0).lane")
                            }
                            
                            if (viewModel.start!.hasResultType(.registration)) {
                                LabeledContent {
                                    Text(viewModel.start!.getResultString(.registration) ?? "+")
                                } label: {
                                    Label("Meldezeit", systemImage: "stopwatch.fill")
                                }
                            }
                            
                        }
                        
                        Section("Sportler") {
                            
                            NavigationLink(
                                destination: AthleteView(athleteId: (viewModel.start?.athlete)!, athleteName: viewModel.start?.athleteName ?? "Sportler")) {
                                    
                                    Text(viewModel.start?.athleteName ?? "-")
                                        .bold()
                                }
                            
                            LabeledContent {
                                Text(String(viewModel.start?.athleteYear ?? 0))
                            } label: {
                                Text("Jahrgang")
                            }
                            
                            LabeledContent {
                                Text(viewModel.start?.athleteTeamName ?? "-")
                            } label: {
                                Text("Verein")
                            }
                        }
                        
                        Section("Ergebnis") {
                            
                            LabeledContent {
                                Text(viewModel.start?.rank != nil ? String(viewModel.start!.rank!) : "-")
                                    .bold()
                                    .foregroundStyle(.primary)
                            } label: {
                                Text("Platz")
                            }
                            
                            if (viewModel.start!.hasResultType(.reaction)) {
                                LabeledContent {
                                    Text(viewModel.start!.getResultString(.reaction) ?? "-")
                                } label: {
                                    Text("Reaktion")
                                }
                            }
                            
                            ForEach(viewModel.start!.getLaps(), id: \.self) { result in
                                LabeledContent {
                                    Text(result.getTimeString())
                                } label: {
                                    Text("Zwischenzeit \(result.lapMeters!)m")
                                }
                            }
                            
                            if (!viewModel.start!.hasResultType(.result_list)) {
                                LabeledContent {
                                    Text(viewModel.start!.getResultString(.livetiming) ?? "-")
                                        .bold()
                                } label: {
                                    Text("Ergebnis (vorl.)")
                                        .bold()
                                }
                            } else {
                                LabeledContent {
                                    Text(viewModel.start!.getResultString(.result_list) ?? "-")
                                        .bold()
                                        .foregroundStyle(.primary)
                                } label: {
                                    Text("Ergebnis")
                                        .bold()
                                }
                            }
                            
                            if (viewModel.start!.hasDisqualification()) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "exclamationmark.bubble.fill")
                                            .foregroundStyle(.red)
                                        Text("Disqualifikation")
                                            .bold()
                                    }
                                    
                                    if (viewModel.start!.disqualification!.type == "dns") {
                                        Text("Nicht am Start!")
                                    } else {
                                        Text(viewModel.start?.disqualification?.reason ?? "-")
                                    }
                                }
                            }
                        }
                    }
                }
                .refreshable {
                    await viewModel.fetchStart()
                }
                .overlay {
                    if viewModel.fetching && viewModel.start == nil {
                        SpinnerView()
                    }
                }
            }
        }
        .task {
            viewModel.startId = startId
            await viewModel.fetchStart()
        }
        .navigationTitle("Start")
    }
}

#Preview {
    NavigationStack {
        StartView(startId: "657199b671d6e4857d2a89bc")
            .environmentObject(CurrentMeeting.example())
    }
    // luca: 65719e5571d6e4857d2a8d6e
    // disq: 657199b671d6e4857d2a89bc
}
