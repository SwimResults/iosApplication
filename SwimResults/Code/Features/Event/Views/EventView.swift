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
    
    var body: some View {
        ZStack {
            
            if viewModel.fetching {
                SpinnerView()
            }
        }
        .onAppear {
            viewModel.setup(currentMeeting)
        }
    }
}

#Preview {
    EventView()
}
