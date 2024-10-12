//
//  LiveView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 19.05.24.
//

import SwiftUI

struct LiveView: View {
    @StateObject private var viewModel = LiveViewModel()
    @EnvironmentObject var currentMeeting: CurrentMeeting;
    
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(viewModel.starts, id: \.self) {start in
                        StartListEntryView(start: start, config: $viewModel.config)
                    }
                } header: {
                    if (viewModel.event != nil) {
                        Text("WK \(viewModel.event!.number) \(viewModel.event!.getEventName())")
                            .font(.title)
                            .textCase(nil)
                    }
                }
                Section {
                    Toggle(isOn: $viewModel.isLive) {
                        Text("Live-Update")
                    }
                    Button("Live-Aktivität starten") {
                        print("test")
                    }
                } header: {
                    Text("Einstellungen")
                } footer: {
                    Text("Die Live-Aktivität zeigt aktuelle Informationen auf dem Sperrbildschirm an.")
                }
            }
        }
        .toolbar {
            if (viewModel.event != nil) {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(viewModel.event!.getEventName())
                            .font(.headline)
                    }
                }
            }
        }
        .onAppear {
            viewModel.setup(currentMeeting)
        }
        .task {
            await viewModel.fetchData()
        }
        .onReceive(viewModel.timer, perform: { _ in
            if (viewModel.isLive) {
                Task {
                    await viewModel.fetchData()
                }
            }
        })
    }
}

#Preview {
    LiveView()
        .environmentObject(CurrentMeeting.exampleWithId("IESC22"))
}
