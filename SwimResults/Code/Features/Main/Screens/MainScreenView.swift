//
//  MainScreenView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import SwiftUI
import AppAuthCore

struct MainScreenView: View {
    @StateObject var currentMeeting: CurrentMeeting = CurrentMeeting();
    @StateObject var authState: AuthState = AuthState()
    
    var body: some View {
        MainView()
            .environmentObject(currentMeeting)
            .environment(authState)
    }
}

#Preview {
    MainScreenView()
}
