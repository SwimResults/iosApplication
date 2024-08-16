//
//  SettingsView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.requestReview) var requestReview
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
                        AdvancedSettingsView()
                    } label: {
                        Label("Erweiterte Einstellungen", systemImage: "gear")
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
                
                Section(header: Text("App")) {
                    Button {
                    showingAlert = true
                    } label: {
                        Label("Teilen", systemImage: "square.and.arrow.up")
                    }.buttonStyle(.plain)
                        .alert(Text("App Bewerten"),
                        isPresented: $showingAlert,
                        actions: {
                            Button("Abbrechen", role: .cancel) {}
                        }, message: {
                            // TODO: remove
                            Text("Die App ist momentan noch nicht im Store verfügbar.")
                        })
                    
                    Button {
                        requestReview()
                    } label: {
                        Label("Bewerten", systemImage: "star")
                    }.buttonStyle(.plain)
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
