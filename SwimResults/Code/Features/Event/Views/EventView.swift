//
//  EventView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import SwiftUI

struct EventView: View {
    @StateObject private var viewModel = EventViewModel()
    public var meetingId: String
    public var eventNumber: Int
    
    var config: StartListConfig = StartListConfig(showAthlete: true, showRegistrationTime: true, laneAsIcon: true, showIcon: true)
    
    var body: some View {
        List {
            if (viewModel.heats != nil) {
                ForEach(Array(viewModel.heats!.keys).sorted(by: <), id: \.self) {heatNumber in
                    Section {
                        ForEach(viewModel.heats![heatNumber]!, id: \.self) {start in
                            StartListEntryView(start: start, config: config)
                        }
                    } header: {
                        HStack {
                            Text("Lauf \(heatNumber)")
                            Spacer()
                            Text(viewModel.heats![heatNumber]![0].heat?.getStartEstimationString() ?? "")
                            Text(viewModel.heats![heatNumber]![0].heat?.getStartDelayEstimationString() ?? "")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            
        }
        .listStyle(.grouped)
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
            if viewModel.fetchingStarts && ((viewModel.heats != nil && viewModel.heats!.count <= 0) || viewModel.heats == nil) {
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
