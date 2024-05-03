//
//  TabView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 02.05.24.
//

import SwiftUI

struct TabView: View {
    
    @State var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            
            VStack {
                Text("Wettkampffolge und Ablaufplan")
            }
            .tabItem {
                Label("Wettkämpfe", systemImage: "figure.pool.swim")
            }
            .navigationTitle("Wettkampffolge")
        }
    }
}

#Preview {
    TabView()
}
