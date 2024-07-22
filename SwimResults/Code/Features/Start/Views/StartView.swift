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
                        
                        LabeledContent {
                            Text(String(viewModel.start?.event ?? 0))
                        } label: {
                            Text("Wettkampf")
                        }
                        
                        LabeledContent {
                            Text(String(viewModel.start?.heat?.number ?? 0))
                        } label: {
                            Text("Lauf")
                        }
                        
                        LabeledContent {
                            Text(String(viewModel.start?.lane ?? 0))
                        } label: {
                            Text("Bahn")
                        }
                        
                        NavigationLink(
                            destination: AthleteView(athleteId: (viewModel.start?.athlete)!, athleteName: viewModel.start?.athleteName ?? "Sportler")) {
                                
                            Text(viewModel.start?.athleteName ?? "-")
                        }
                        
                        LabeledContent {
                            Text(viewModel.start?.athleteTeamName ?? "-")
                        } label: {
                            Text("Verein")
                        }
                        
                        Text(viewModel.start?.addedAt?.ISO8601Format() ?? "-")
                    }
                }
                .refreshable {
                    await viewModel.fetchStart()
                }
                .overlay {
                    if viewModel.fetching {
                        SpinnerView()
                    }
                }
            }
        }
        .task {
            viewModel.startId = startId
            await viewModel.fetchStart()
        }
    }
}

#Preview {
    NavigationStack {
        StartView(startId: "65719e5571d6e4857d2a8d6e")
            .environmentObject(CurrentMeeting.example())
    }
}
