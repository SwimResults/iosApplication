//
//  MainTabItemView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import SwiftUI

struct MainTabItemView<Content: View>: View where Content : View {
    var needsMeeting: Bool = true
    
    @State var title = "Seite"
    @State var showMeetingSelection = false
    
    @EnvironmentObject var currentMeeting: CurrentMeeting
    
    @ViewBuilder let content: Content
    
    var body: some View {
            
        NavigationStack {
            VStack {
                if (needsMeeting && currentMeeting.meeting == nil) {
                    VStack {
                        Image(systemName: "calendar.badge.exclamationmark")
                            .foregroundStyle(.red, .gray)
                            .font(.system(size: 60))
                        Text("Keine Veranstaltung ausgewählt!")
                        Button(action: {showMeetingSelection = true}) {
                            HStack {
                                Image(systemName: "calendar")
                                    .imageScale(.large)
                                Text("Veranstaltung auswählen")
                            }
                        }
                            .buttonStyle(.borderedProminent)
                            .padding()
                    }
                } else {
                    content
                        .padding(.bottom, 70)
                        
                        /*.safeAreaInset(edge: .bottom) {
                            ZStack {
                                Color(U)
                                VStack {
                                    Divider()
                                    Spacer()
                                    HStack {
                                        Circle()
                                            .frame(width: 12, height: 12)
                                            .foregroundStyle(.red)
                                        Text("Live")
                                    }
                                }
                            }
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .backgroundStyle(.gray)
                        }*/
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button(action: {showMeetingSelection = true}) {
                    Image(systemName: "calendar.badge.checkmark")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.green, .primary)
                        .imageScale(.large)
                }
            }
            .toolbarBackground(.visible, for: .tabBar)
        }
        .fullScreenCover(isPresented: $showMeetingSelection, content: {
            NavigationView {
                MainMeetingListView(isPresented: $showMeetingSelection)
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
                                .font(.title2)
                        }
                    }
                }
            }
            
        })
    }
}

#Preview {
    /*MainTabItemView(title: "Test Seite") {
        Text("Testing")
    }.environmentObject(CurrentMeeting())*/
    
    MainView().environmentObject(CurrentMeeting.example())
}
