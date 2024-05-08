//
//  MainScreenView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject var currentMeeting: CurrentMeeting = CurrentMeeting();
    
    var body: some View {
        MainView()
            .environmentObject(currentMeeting)
    }
}

#Preview {
    MainScreenView()
}
