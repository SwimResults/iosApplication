//
//  AthleteView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 14.07.24.
//

import SwiftUI

struct AthleteView: View {
    @EnvironmentObject var currentMeeting: CurrentMeeting
    
    @ObservedObject private var viewModel = EventViewModel()
    var athlete: AthleteModel;
    
    var body: some View {
        ZStack {
            
            if viewModel.fetching {
                SpinnerView()
            } else {
                VStack {
                    List {
                        
                        LabeledContent {
                            Text((athlete.year != nil) ? String(athlete.year!) : "-")
                        } label: {
                            Label("Jahrgang", systemImage: "calendar")
                        }
                        
                        LabeledContent {
                            Text(athlete.getGender())
                        } label: {
                            Label("Geschlecht", systemImage: "figure.dress.line.vertical.figure")
                        }
                        
                        LabeledContent {
                            Text(athlete.team?.name ?? "-")
                        } label: {
                            Label("Verein", systemImage: "person.3.sequence.fill")
                        }
                        
                        LabeledContent {
                            Text(athlete.team?.country ?? "-")
                        } label: {
                            Label("Land", systemImage: "flag.fill")
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.setup(currentMeeting)
        }
        .navigationTitle(athlete.name)
    }
}

#Preview {
    NavigationStack {
        AthleteView(athlete: AthleteModel(_id: "", name: "Konrad Weiß", gender: "MALE", team: TeamModel(_id: "", name: "ST Erzgebirge")))
            .environmentObject(CurrentMeeting.example())
    }
}
