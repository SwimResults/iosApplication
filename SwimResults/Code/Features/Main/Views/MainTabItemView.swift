//
//  MainTabItemView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import SwiftUI

struct MainTabItemView<Content: View>: View where Content : View {
    @State var title = "Seite"
    @State var showMeetingSelection = false
    
    @ViewBuilder let content: Content
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle(title)
                .toolbar {
                    Button(action: {showMeetingSelection = true}) {
                        Image(systemName: "calendar.badge.checkmark")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.green, .primary)
                            .imageScale(.large)
                    }
                }
        }
        .sheet(isPresented: $showMeetingSelection, content: {
            NavigationView {
                MainMeetingListScreenView()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Veranstaltung auswählen").font(.headline)
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {showMeetingSelection = false}) {
                            Image(systemName: "xmark.circle.fill")
                                .symbolRenderingMode(.hierarchical)
                        }
                    }
                }
            }
            
        })
    }
}

#Preview {
    MainTabItemView(title: "Test Seite") {
        Text("Testing")
    }
}