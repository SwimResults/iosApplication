//
//  MainView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 02.05.24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @AppStorage("CURRENT_MEETING_ID") var savedMeetingId: String = "";
    @EnvironmentObject var currentMeeting: CurrentMeeting;
    
    // TODO: increase interval
    let timer = Timer.publish(every: 45, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            if (viewModel.fetching) {
                SpinnerView("Lade Veranstaltung...")
            } else {
                VStack {
                    TabView {
                        
                        MainTabItemView(title: "Wettkampffolge", sheetMode: $viewModel.sheetMode) {
                            EventScreenView()
                        }
                        .tabItem {
                            Label("Wettkämpfe", systemImage: "figure.pool.swim")
                        }
                        
                        MainTabItemView(title: "Meine Favoriten", sheetMode: $viewModel.sheetMode) {
                            Text("Favoriten (Vereine und Sportler)")
                        }
                        .tabItem {
                            Label("Favoriten", systemImage: "star")
                        }
                        
                        MainTabItemView(title: "Suche", sheetMode: $viewModel.sheetMode) {
                            SearchScreenView()
                        }
                        .tabItem {
                            Label("Suche", systemImage: "magnifyingglass.circle.fill")
                        }
                        
                        MainTabItemView(title: "Veranstaltung", sheetMode: $viewModel.sheetMode) {
                            MeetingScreenView()
                        }
                        .tabItem {
                            Label("Veranstaltung", systemImage: "calendar")
                        }
                        
                        MainTabItemView(needsMeeting: false, title: "Einstellungen", sheetMode: $viewModel.sheetMode) {
                            SettingsScreenView()
                        }
                        .tabItem {
                            Label("Einstellungen", systemImage: "gear")
                        }
                        
                        
                    }
                }
            }
        }
        .onReceive(currentMeeting.$meeting, perform: { meeting in
            /// if current meeting is changed and deferes from the meeting in app storage, refresh the meeting
            if (meeting != nil && meeting!.meetId != "") {
                
                if (savedMeetingId != meeting!.meetId) {
                    print("refreshing meeting data")
                    Task {
                        await viewModel.fetchMeeting(meeting!.meetId)
                    }
                    savedMeetingId = meeting!.meetId
                    print("stored meeting " + savedMeetingId + " in AppStorage")
                } else {
                    savedMeetingId = meeting!.meetId
                    print("stored meeting " + savedMeetingId + " in AppStorage again")
                }
            }

        })
        .onReceive(timer, perform: { _ in
            if (savedMeetingId != "") {
                print("update current meeting")
                Task {
                    await viewModel.fetchMeeting(savedMeetingId, silent: true)
                }
            }
        })
        .onAppear {
            viewModel.setup(currentMeeting)
            viewModel.sheetMode = .none
        }
        .task {
            if (savedMeetingId != "") {
                await viewModel.fetchMeeting(savedMeetingId)
            }
        }
        .sheet(isPresented: .constant(viewModel.sheetMode == SheetMode.meetingSelection), onDismiss: {
            viewModel.sheetMode = .none
        }, content: {
            NavigationView {
                MainMeetingListView(sheetMode: $viewModel.sheetMode)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Veranstaltung auswählen").font(.headline)
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {viewModel.sheetMode = .none}) {
                            Image(systemName: "xmark.circle.fill")
                                .symbolRenderingMode(.hierarchical)
                                .font(.title2)
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {viewModel.sheetMode = .none; currentMeeting.meeting = nil}) {
                            Text("keine")
                        }
                    }
                }
            }
        })
        .sheet(isPresented: .constant(viewModel.sheetMode == SheetMode.live), onDismiss: {
            viewModel.sheetMode = .none
        }, content: {
            NavigationView {
                LiveView()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Live").font(.headline)
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {viewModel.sheetMode = .none}) {
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
    MainView().environmentObject(CurrentMeeting.example())
}
