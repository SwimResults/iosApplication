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
    
    var config: StartListConfig = StartListConfig(showAthlete: true, laneAsIcon: true)
    
    var body: some View {
        List {
            if (viewModel.heats != nil) {
                ForEach(Array(viewModel.heats!.keys).sorted(by: <), id: \.self) {heatNumber in
                    Section("Lauf \(heatNumber)") {
                        ForEach(viewModel.heats![heatNumber]!, id: \.self) {start in
                            StartListEntryView(start: start, config: config)
                        }
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(meetingEvent.getEventName())
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EventView(meetingEvent: EventModel(_id: "", number: 10, distance: 50, meeting: "IESC23", gender: "MALE", style: StyleModel(_id: "", name: "BUTTERFLY", aliases: []))).environmentObject(CurrentMeeting.example())
    }
}
