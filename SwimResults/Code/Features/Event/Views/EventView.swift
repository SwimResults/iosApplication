//
//  EventView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var currentMeeting: CurrentMeeting
    
    @ObservedObject private var viewModel = EventViewModel()
    var meetingEvent: EventModel;
    
    var body: some View {
        List {
            Section{} header: {
                Text(meetingEvent.getEventName())
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primary)
            }
            
            if (viewModel.starts != nil) {
                Section("Lauf 2") {
                    ForEach(viewModel.starts!, id: \.self) {start in
                        StartListEntryView(start: start)
                    }
                }
            }
            
        }
        .listStyle(.sidebar)
        .refreshable {
            await viewModel.fetchStarts()
        }
        .task {
            viewModel.setup(currentMeeting)
            viewModel.meetingEvent = meetingEvent
            await viewModel.fetchStarts()
        }
        .overlay {
            if viewModel.fetching {
                SpinnerView()
            }
        }
        .navigationTitle(Text("Wettkampf \(meetingEvent.number)"))
    }
}

#Preview {
    NavigationStack {
        EventView(meetingEvent: EventModel(_id: "", number: 10, distance: 50, meeting: "IESC23", gender: "MALE", style: StyleModel(_id: "", name: "BUTTERFLY", aliases: []))).environmentObject(CurrentMeeting.example())
    }
}
