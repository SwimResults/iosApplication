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
    let timer = Timer.publish(every: 180, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            if (viewModel.fetching) {
                SpinnerView("Lade Veranstaltung...")
            } else {
                TabView {
                    
                    MainTabItemView(title: "Wettkampffolge") {
                        EventScreenView()
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
                        MeetingScreenView()
                    }
                    .tabItem {
                        Label("Veranstaltung", systemImage: "calendar")
                    }
                    
                    MainTabItemView(needsMeeting: false, title: "Einstellungen") {
                        SettingsScreenView()
                    }
                    .tabItem {
                        Label("Einstellungen", systemImage: "gear")
                    }
                    
                    
                }
                .sheet(isPresented: .constant(currentMeeting.meeting?.state == "RUNNING")) {
                    HStack {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.red)
                        Text("Live")
                    }
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.height(70), .fraction(0.99)])
                    .presentationBackgroundInteraction(.enabled)
                    .presentationCornerRadius(0)
                    .presentationBackground(.regularMaterial)
                    .interactiveDismissDisabled()
                    .bottomMaskForSheet()
                }
            }
        }
        .onReceive(currentMeeting.$meeting, perform: { meeting in
            
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
        }
        .task {
            if (savedMeetingId != "") {
                await viewModel.fetchMeeting(savedMeetingId)
            }
        }
    }
}

#Preview {
    MainView().environmentObject(CurrentMeeting.example())
}
