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
    
    @State var config: StartListConfig = StartListConfig(showAthlete: true, showRegistrationTime: true, laneAsIcon: true, showIcon: true)
    
    var body: some View {
        VStack {
            List {
                Section {} header: {
                    VStack {
                        Picker("", selection: $viewModel.viewMode) {
                            Text("Starts").tag(EventViewMode.starts)
                            Text("Ziel").tag(EventViewMode.finish)
                            Text("Ergebnis").tag(EventViewMode.results)
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: viewModel.viewMode) {
                            config.showMostSignificantTime = viewModel.viewMode != .starts
                            config.showRegistrationTime = viewModel.viewMode == .starts
                            config.laneAsIcon = viewModel.viewMode == .starts
                            //config.showDisqualification = viewModel.viewMode == .finish
                            config.rankStylesIcon = viewModel.viewMode == .results
                            viewModel.refreshForViewMode()
                        }
                    }
                    .textCase(nil)
                }
                
                if (viewModel.viewMode == .starts || viewModel.viewMode == .finish) {
                    if (viewModel.heats != nil) {
                        ForEach(Array(viewModel.heats!.keys).sorted(by: <), id: \.self) {heatNumber in
                            Section {
                                ForEach(viewModel.heats![heatNumber]!, id: \.self) {start in
                                    StartListEntryView(start: start, config: $config)
                                }
                            } header: {
                                HStack {
                                    Text("Lauf \(heatNumber)")
                                    Spacer()
                                    
                                    let heat = viewModel.heats![heatNumber]![0].heat
                                    if (heat != nil) {
                                        Text(heat!.getStartEstimationString() ?? "")
                                        Text(heat!.getStartDelayEstimationString() ?? "")
                                            .foregroundStyle(heat!.getDelayType().color)
                                    }
                                }
                            }
                        }
                    }
                }
                
                if (viewModel.viewMode == .results) {
                    if (viewModel.results != nil) {
                        ForEach(viewModel.results!, id: \.self) {ageResult in
                            Section {
                                ForEach(ageResult.starts, id: \.self) {start in
                                    StartListEntryView(start: start, config: $config)
                                }
                            } header: {
                                Text(ageResult.ageGroup?.name ?? "Jahrgang")
                            }
                        }
                    }
                }
                
            }
            .listStyle(.grouped)
            .refreshable {
                await viewModel.fetchEvent()
                if (viewModel.viewMode == .results) {
                    await viewModel.fetchResults()
                } else {
                    await viewModel.fetchStarts()
                }
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
