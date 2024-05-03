//
//  MainView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 02.05.24.
//

import SwiftUI

struct MainView: View {
    @State var selection = 1
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                
                VStack {
                    NavigationStack {
                        Text("Wettkampffolge und Ablaufplan")
                            .navigationTitle("Wettkampffolge")
                    }
                }
                .tabItem {
                    Label("Wettkämpfe", systemImage: "figure.pool.swim")
                }
                
                VStack {
                    NavigationStack {
                        Text("Favoriten (Vereine und Sportler)")
                            .navigationTitle("Meine Favoriten")
                    }
                }
                .tabItem {
                    Label("Favoriten", systemImage: "star")
                }
                
                VStack {
                    NavigationStack {
                        Text("Hier suchen!!")
                        Text("Sportler-, Vereins- und Streckensuche")
                            .navigationTitle("Suche")
                    }
                }
                .tabItem {
                    Label("Suche", systemImage: "magnifyingglass.circle.fill")
                }
                
                VStack {
                    NavigationStack {
                        Text("27. Internationaler Erzgebirgsschwimmcup 2024")
                            .navigationTitle("Veranstaltung")
                    }
                }
                .tabItem {
                    Label("Veranstaltung", systemImage: "info")
                }
                
                
            }
        }
    }
}

#Preview {
    MainView()
}
