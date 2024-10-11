//
//  SettingsView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import SwiftUI

struct SettingsView: View {
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Einstellungen")) {
                    
                    NavigationLink {
                        AppearanceSettingsView()
                    } label: {
                        Label("Erscheinungsbild", systemImage: "paintbrush")
                    }
                    
                    NavigationLink {
                        AppIconSettingsView()
                    } label: {
                        Label("App Icon", systemImage: "app.dashed")
                    }
                    
                    NavigationLink {
                        NotificationSettingsView()
                    } label: {
                        Label("Benachrichtigungen", systemImage: "bell.badge.fill")
                    }
                    
                    NavigationLink {
                        AdvancedSettingsView()
                    } label: {
                        Label("Erweiterte Einstellungen", systemImage: "gear")
                    }
                    
                    NavigationLink {
                        TestLoginView()
                    } label: {
                        Label("Login Test", systemImage: "person")
                    }
                }
                
                Section(header: Text("Entwickler")) {
                    Link(destination: URL(string: "https://swimresults.de/contact")!, label: {
                        Label("Kontakt", systemImage: "envelope")
                    }).buttonStyle(.plain)
                    
                    Link(destination: URL(string: "https://swimresults.de/impressum")!, label: {
                        Label("Impressum", systemImage: "person")
                    }).buttonStyle(.plain)
                
                    Link(destination: URL(string: "https://swimresults.de/")!, label: {
                        Label("Webseite", systemImage: "globe")
                    }).buttonStyle(.plain)
                }
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
