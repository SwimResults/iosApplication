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
                    
                    Text("Abschnitt " + String(part.number)).font(.title).bold()
                    
                    Section {
                        ForEach(part.events, id: \.self) {meetingEvent in
                            HStack {
                                Text("\(meetingEvent.number)")
                                Text(meetingEvent.getEventName())
                            }
                            
                        }
                    }
                }
            }
            
            if viewModel.fetching {
                SpinnerView()
            }
        }
        .onAppear {
            viewModel.setup(currentMeeting)
            viewModel.fetchEventParts()
        }
    }
}

#Preview {
    EventListView()
        .environmentObject(CurrentMeeting.example())
}
