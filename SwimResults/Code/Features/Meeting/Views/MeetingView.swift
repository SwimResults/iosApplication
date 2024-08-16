//
//  MeetingView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 09.05.24.
//

import SwiftUI
import CoreLocation
import MapKit

struct MeetingView: View {
    @EnvironmentObject var currentMeeting: CurrentMeeting
    @StateObject var viewModel: MeetingViewModel = MeetingViewModel()
    
    var body: some View {
        ZStack {
            /*LinearGradient(
                colors: [
                    Color(hex: meeting?.layout?.colorSet?.primary ?? "a3ffff"),
                    Color(hex: meeting?.layout?.colorSet?.secondary ?? "ffa3ed"),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()*/
            
            VStack {
                if (viewModel.meeting != nil) {
                    List {
                        
                        Section(content: {
                            
                            LabeledContent {
                                Text(viewModel.meeting!.getStartDateString() )
                            } label: {
                                Label("Start", systemImage: "calendar")
                            }
                            
                            LabeledContent {
                                Text(viewModel.meeting!.getEndDateString() )
                            } label: {
                                Label("Ende", systemImage: "calendar")
                            }
                            
                            LabeledContent {
                                Text(viewModel.meeting!.getStateString())
                            } label: {
                                Label("Status", systemImage: "dot.radiowaves.right")
                            }
                            
                            LabeledContent {
                                Text(viewModel.team?.name ?? "-")
                            } label: {
                                Label("Ausrichter", systemImage: "person.2.fill")
                            }
                            
                            if (viewModel.meeting?.location != nil) {
                                LabeledContent {
                                    VStack(alignment: .trailing) {
                                        Text(viewModel.meeting!.location!.name ?? "")
                                            .bold()
                                        Text("\(viewModel.meeting!.location!.street ?? "") \(viewModel.meeting!.location!.number ?? "")")
                                        Text("\(viewModel.meeting!.location!.postalCode ?? "") \(viewModel.meeting!.location!.city ?? "")")
                                    }
                                } label: {
                                    Label("Adresse", systemImage: "mappin.and.ellipse")
                                }
                                
                                
                                if (viewModel.location != nil) {
                                    NavigationLink {
                                        MeetingLocationMapView(name: viewModel.meeting?.location?.getAddressString() ?? "Wettkampfstätte", location: viewModel.location!)
                                    } label: {
                                        Label("Karte", systemImage: "map.fill")
                                    }
                                }
                            }
                        }, header: {
                            VStack {
                                HStack {
                                    Spacer()
                                    
                                    ZStack {
                                        Circle().fill(.white).frame(width: 150, height: 150)
                                        AsyncImage(url: URL(string: viewModel.meeting!.layout?.logoUrl ?? "")) { image in
                                            image.resizable().aspectRatio(contentMode: .fit).clipShape(Circle())
                                        } placeholder: {
                                            SpinnerView()
                                        }.frame(width: 120, height: 120)
                                    }
                                    
                                    Spacer()
                                }
                                .padding()
                                
                                
                                Text(viewModel.meeting!.getFullName() )
                                    .multilineTextAlignment(.center)
                                    .font(.headline)
                                    .foregroundStyle(.foreground)
                            }
                            .padding()
                        })
                    }
                    .refreshable {
                        await viewModel.fetchMeeting()
                        await viewModel.fetchTeam()
                    }
                }
            }
        }.task {
            viewModel.setup(currentMeeting)
            await viewModel.fetchMeeting()
            await viewModel.fetchTeam()
        }
    }
}

#Preview {
    MeetingView().environmentObject(CurrentMeeting.example())
}
