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
        ZStack {
            if viewModel.fetching {
                SpinnerView()
            } else {
                if (viewModel.parts.count > 0) {
                    List {
                        ForEach(viewModel.parts, id: \.self) { part in
                            
                            
                            Section( content: {
                                ForEach(part.events, id: \.self) {meetingEvent in
                                    NavigationLink(destination: EventView(meetingEvent: meetingEvent)) {
                                        HStack {
                                            Text("\(meetingEvent.number)")
                                                .frame(width: 30, height: 30)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Color.blue)
                                                )
                                                .foregroundStyle(.white)
                                                .font(.caption)
                                                .fontWeight(.bold)
                                            VStack {
                                                HStack {
                                                    Text(meetingEvent.getEventName())
                                                    Spacer()
                                                }
                                                HStack {
                                                    Text("10 Läufe")
                                                        .font(.caption)
                                                    Spacer()
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
                    .listStyle(.sidebar)
                    .refreshable {
                        await viewModel.fetchEventParts()
                    }
                } else {
                    ContentUnavailableView {
                        Label("Keine Wettkämpfe", systemImage: "calendar")
                    } description: {
                        Text("Für diese Veranstaltung wurden keine Wettkämpfe gefunden.")
                    }
                }
            }
        }
        .task {
            viewModel.setup(currentMeeting)
            await viewModel.fetchEventParts()
        }
    }
}

#Preview {
    EventListView()
        .environmentObject(CurrentMeeting.example())
}
