//
//  MainMeetingListView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import SwiftUI

struct MainMeetingListView: View {
    var body: some View {
        VStack {
            List {
                Text("2024").font(.title).bold()
                Section {
                    
                    Button {
                        
                    } label: {
                        Label("Deutsche Meisterschaften im Finswimming 2024", systemImage: "calendar")
                    }.foregroundColor(.primary)
                    
                    Button {
                        
                    } label: {
                        Label("Bezirksmeisterschaften des BSV Südwestsachsen 2024", systemImage: "calendar")
                    }.foregroundColor(.primary)
                    
                    Button {
                        
                    } label: {
                        Label("27. Internationaler Erzgebirgsschwimmcup 2024", systemImage: "calendar")
                    }.foregroundColor(.primary)
                    
                }
                
                Text("2023").font(.title).bold()
                
                Section {
                    
                    Button {
                        
                    } label: {
                        Label("Erzgebirgsspiele Schwimmen Finale 2023", systemImage: "calendar")
                    }.foregroundColor(.primary)
                    
                    Button {
                        
                    } label: {
                        Label("26. Internationaler Erzgebirgsschwimmcup 2023", systemImage: "calendar")
                    }.foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview {
    MainMeetingListView()
}