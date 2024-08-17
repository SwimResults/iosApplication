//
//  NotificationSettingsView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 17.08.24.
//

import SwiftUI
import UserNotifications

struct NotificationSettingsView: View {
    let notificationCenter = UNUserNotificationCenter.current()
    
    var body: some View {
        List {
            Button("Request Notification Access") {
                Task {
                    do {
                        try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
                    } catch {
                        print("Request authorization error")
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }.navigationTitle("Benachrichtigungen")
    }
}

#Preview {
    NotificationSettingsView()
}
