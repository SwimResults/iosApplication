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
            List {
                ForEach(viewModel.parts, id: \.self) { part in
                    
                    
                    Section( content: {
                        ForEach(part.events, id: \.self) {meetingEvent in
                            HStack {
                                Text("\(meetingEvent.number)")
                                Text(meetingEvent.getEventName())
                            }
                            
                        }
                    }, header: {
                        Text("Abschnitt " + String(part.number))
                    })
                }
            }
            .listStyle(.sidebar)
            .refreshable {
                await viewModel.fetchEventParts()
            }
            
            if viewModel.fetching {
                SpinnerView()
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
