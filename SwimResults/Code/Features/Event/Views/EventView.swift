//
//  EventView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import SwiftUI

struct EventView: View {
    @ObservedObject private var viewModel = EventViewModel()
    public var meetingId: String
    public var eventNumber: Int
    
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
            await viewModel.fetchEvent()
            await viewModel.fetchStarts()
        }
        .task {
            viewModel.eventNumber = eventNumber
            viewModel.meetingId = meetingId
            await viewModel.fetchEvent()
            await viewModel.fetchStarts()
        }
        .overlay {
            if viewModel.fetching {
                SpinnerView()
            }
        }
        .navigationTitle(Text("Wettkampf \(eventNumber)"))
        .toolbar {
            if (viewModel.meetingEvent != nil) {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(viewModel.meetingEvent!.getEventName())
                            .font(.headline)
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
}
