//
//  LiveBarView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 08.06.24.
//

import SwiftUI

struct LiveBarView: View {
    @StateObject private var viewModel = LiveBarViewModel()
    @EnvironmentObject var currentMeeting: CurrentMeeting;
    
    var body: some View {
        VStack {
            if (viewModel.fetching) {
                SpinnerView()
            } else {
                VStack {
                    HStack {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.red)
                        Text("Live")
                    }
                    Text("WK: " + String(viewModel.currentHeat?.event ?? 0))
                }
            }
        }
        .onAppear {
            viewModel.setup(currentMeeting)
        }
        .task {
            await viewModel.fetchCurrentHeat(currentMeeting.meeting!.meetId)
        }
    }
}

#Preview {
    MainView()
        .environmentObject(CurrentMeeting.example())
}
