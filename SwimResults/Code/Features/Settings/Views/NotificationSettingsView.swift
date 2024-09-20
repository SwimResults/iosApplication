//
//  NotificationSettingsView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 17.08.24.
//

import SwiftUI
import UserNotifications

struct NotificationSettingsView: View {
    @State var isNotifyMyself: Bool = false

    let notificationCenter = UNUserNotificationCenter.current()
    
    var body: some View {
        Form {
            
            Toggle("Eigener Sportler", isOn: $isNotifyMyself)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .onChange(of: isNotifyMyself) {
                    
                }
            
            Toggle("Favoriten", isOn: $isNotifyMyself)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .onChange(of: isNotifyMyself) {
                    
                }
            
            Toggle("Veranstaltungen", isOn: $isNotifyMyself)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .onChange(of: isNotifyMyself) {
                    
                }
            
            Toggle("Zeitplan", isOn: $isNotifyMyself)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .onChange(of: isNotifyMyself) {
                    
                }
            
            Button("Request Notification Access") {
                Task {
                    do {
                        try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
                    } catch {
                        print("Request authorization error")
                    }
                }
            }
        }.navigationTitle("Benachrichtigungen")
    }
}

#Preview {
    NotificationSettingsView()
}
