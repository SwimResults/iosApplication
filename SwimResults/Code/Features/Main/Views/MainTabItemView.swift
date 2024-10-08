//
//  MainTabItemView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import SwiftUI

struct MainTabItemView<Content: View>: View where Content : View {
    var needsMeeting: Bool = true
    
    @State var title: Text = Text("Seite")
    @Binding var sheetMode: SheetMode
    @Binding var fetching: Bool
    
    @Binding var showNavigation: Bool
    
    @EnvironmentObject var currentMeeting: CurrentMeeting
    
    @ViewBuilder let content: Content
    
    var body: some View {
            
        NavigationStack {
            VStack {
                if (fetching) {
                    SpinnerView("Lade Veranstaltung...")
                } else if (needsMeeting && currentMeeting.meeting == nil) {
                    VStack {
                        ContentUnavailableView {
                            Label {
                                Text("Keine Veranstaltung ausgewählt!")
                            } icon: {
                                Image(systemName: "calendar.badge.exclamationmark")
                                    .foregroundStyle(.red, .gray)
                            }
                        } description: {
                            Text("Wähle eine Veranstaltung aus, um ihre Wettkämpfe und weitere Daten anzuzeigen.")
                            Button(action: {sheetMode = .meetingSelection}) {
                                HStack {
                                    Image(systemName: "calendar")
                                        .imageScale(.large)
                                    Text("Veranstaltung auswählen")
                                }
                            }
                            .padding()
                            
                        }
                        
                    }
                } else {
                    content
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button(action: {sheetMode = .meetingSelection}) {
                    Image(systemName: "calendar.badge.checkmark")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.green, .primary)
                        .imageScale(.large)
                }
            }
            .toolbarBackground(.visible, for: .tabBar)
        }
        .safeAreaInset(edge: .bottom) {
            if (currentMeeting.meeting?.state == "RUNNING") {
                Button(action: {sheetMode = .live}) {
                    ZStack {
                        Color.clear
                            .background(Material.bar)
                        VStack {
                            Divider()
                            Spacer()
                            LiveBarView()
                            Spacer()
                        }
                    }
                    .frame(height: 60)
                }
            }
        }
    }
}

#Preview {
    /*MainTabItemView(title: "Test Seite") {
        Text("Testing")
    }.environmentObject(CurrentMeeting())*/
    
    //MainView().environmentObject(CurrentMeeting.example())
    MainView().environmentObject(CurrentMeeting())
}
