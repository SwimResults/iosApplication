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
                    Spacer()
                    Toggle(isOn: $viewModel.isLive) {
                        Text("Live")
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
}
