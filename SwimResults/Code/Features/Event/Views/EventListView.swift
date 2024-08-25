//
//  EventListView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 08.05.24.
//

import SwiftUI

struct EventListView: View {
    @EnvironmentObject var currentMeeting: CurrentMeeting
    
    @ObservedObject private var viewModel = EventListViewModel()
    
    var body: some View {
        VStack {
            if (viewModel.parts.isEmpty && !viewModel.fetching) {
                ContentUnavailableView {
                    Label("Keine Wettkämpfe", systemImage: "calendar")
                } description: {
                    Text("Für diese Veranstaltung wurden keine Wettkämpfe gefunden.")
                }
            } else {
                List {
                    ForEach(viewModel.parts, id: \.self) { part in
                        Section( content: {
                            ForEach(part.events, id: \.self) {meetingEvent in
                                NavigationLink(destination: EventView(meetingId: meetingEvent.meeting, eventNumber: meetingEvent.number)) {
                                    HStack {
                                        if (viewModel.heatInfo[meetingEvent.number] != nil) {
                                            let heat = viewModel.heatInfo[meetingEvent.number]!.firstHeat
                                            if (heat != nil) {
                                                VStack {
                                                    Text(heat!.getStartEstimationString() ?? "--:--")
                                                    Text(heat!.getStartDelayEstimationString() ?? "--:--")
                                                        .foregroundStyle(heat!.getDelayType().color)
                                                }.frame(width: 36)
                                                    .font(.caption)
                                            }
                                        }
                                        Text("\(meetingEvent.number)")
                                            .frame(width: 30, height: 30)
                                            .background(
                                                RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Color.blue)
                                            )
                                            .foregroundStyle(.white)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                        VStack (alignment: .leading) {
                                            Text(meetingEvent.getEventName())
                                            if (viewModel.heatInfo[meetingEvent.number] != nil) {
                                                if (viewModel.heatInfo[meetingEvent.number]!.amount == 1) {
                                                    Text("1 Lauf")
                                                        .font(.caption)
                                                } else {
                                                    Text("\(viewModel.heatInfo[meetingEvent.number]!.amount) Läufe")
                                                        .font(.caption)
                                                }
                                            }
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                
                            }
                        }, header: {
                            Text("Abschnitt \(part.number)")
                        })
                    }
                }
                .refreshable {
                    await viewModel.fetchEventParts()
                    await viewModel.fetchHeatInfo()
                }
                .listStyle(.grouped)
                .overlay {
                    if viewModel.fetching && viewModel.parts == [] {
                        SpinnerView()
                    }
                }
            }
        }
        .task {
            viewModel.setup(currentMeeting)
            await viewModel.fetchEventParts()
            await viewModel.fetchHeatInfo()
        }
    }
}

#Preview {
    NavigationStack {
        EventListView()
            .environmentObject(CurrentMeeting.example())
    }
}
