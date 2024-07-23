//
//  SettingsView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            List {
                Section(header: Text("Einstellungen")) {
                    Label("Erscheinungsbild", systemImage: "paintbrush")
                    Label("App Icon", systemImage: "app.dashed")
                    NavigationLink {
                        AdvancedSettingsView()
                    } label: {
                        Label("Erweiterte Einstellungen", systemImage: "gear")
                    }
                }
                
                Section(header: Text("Entwickler")) {
                    Label("Kontakt", systemImage: "envelope")
                    Label("Impressum", systemImage: "person")
                    Label("Webseite", systemImage: "globe")
                }
                
                Section(header: Text("App")) {
                    Label("Teilen", systemImage: "square.and.arrow.up")
                    Label("Bewerten", systemImage: "star")
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
