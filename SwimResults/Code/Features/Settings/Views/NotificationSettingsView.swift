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
    
    func register(_ token: String) async {
        do {
            try await registerNotificationUser(token)
        } catch {
            print(error)
        }
    }
    
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
            
            Button("Register Notification User") {
                Task {
                    await register("abcdefghijkl12345")
                }
            }
        }.navigationTitle("Benachrichtigungen")
    }
}

#Preview {
    NotificationSettingsView()
}
