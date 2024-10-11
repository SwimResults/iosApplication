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
    @AppStorage("CURRENT_THEME") private var currentTheme: Theme = .systemDefault
    @EnvironmentObject var currentMeeting: CurrentMeeting;
    
    @State var activeView: Int = 0
    @State var showNavigation: Bool = true
    
    // TODO: increase interval
    // Timer to update current meeting in the background
    let timer = Timer.publish(every: 45, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            VStack {
                TabView {
                    
                    MainTabItemView(title: Text("Wettkampffolge"), sheetMode: $viewModel.sheetMode, fetching: $viewModel.fetching, showNavigation: $showNavigation) {
                        EventScreenView()
                    }
                    .tabItem {
                        Label("Wettkämpfe", systemImage: "figure.pool.swim")
                    }
                    
                    MainTabItemView(title: Text("Meine Seite"), sheetMode: $viewModel.sheetMode, fetching: $viewModel.fetching, showNavigation: $showNavigation) {
                        UserScreenView()
                    }
                    .tabItem {
                        Label("Meins", systemImage: "person")
                    }
                    
                    MainTabItemView(title: Text("Suche"), sheetMode: $viewModel.sheetMode, fetching: $viewModel.fetching, showNavigation: $showNavigation) {
                        SearchScreenView()
                    }
                    .tabItem {
                        Label("Suche", systemImage: "magnifyingglass.circle.fill")
                    }
                    
                    MainTabItemView(title: Text("Veranstaltung"), sheetMode: $viewModel.sheetMode, fetching: $viewModel.fetching, showNavigation: $showNavigation) {
                        MeetingScreenView()
                    }
                    .tabItem {
                        Label("Veranstaltung", systemImage: "calendar")
                    }
                    
                    MainTabItemView(needsMeeting: false, title: Text("Einstellungen"), sheetMode: $viewModel.sheetMode, fetching: $viewModel.fetching, showNavigation: $showNavigation) {
                        SettingsScreenView()
                    }
                    .tabItem {
                        Label("Einstellungen", systemImage: "gear")
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
        .preferredColorScheme(currentTheme.colorScheme)
    }
}

#Preview {
    MainView().environmentObject(CurrentMeeting.example())
}
