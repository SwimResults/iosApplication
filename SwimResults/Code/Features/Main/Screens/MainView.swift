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
        TabView(selection: $selection) {
            
            MainTabItemView(title: "Wettkampffolge") {
                Text("Wettkampffolge und Ablaufplan")
            }
            .tabItem {
                Label("Wettkämpfe", systemImage: "figure.pool.swim")
            }
            
            MainTabItemView(title: "Meine Favoriten") {
                Text("Favoriten (Vereine und Sportler)")
            }
            .tabItem {
                Label("Favoriten", systemImage: "star")
            }
            
            MainTabItemView(title: "Suche") {
                SearchScreenView()
            }
            .tabItem {
                Label("Suche", systemImage: "magnifyingglass.circle.fill")
            }
            
            MainTabItemView(title: "Veranstaltung") {
                Text("27. Internationaler Erzgebirgsschwimmcup 2024")
            }
            .tabItem {
                Label("Veranstaltung", systemImage: "calendar")
            }
            
            
        }
    }
}

#Preview {
    MainView()
}
