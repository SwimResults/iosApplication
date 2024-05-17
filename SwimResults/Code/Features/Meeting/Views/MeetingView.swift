//
//  MeetingView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 09.05.24.
//

import SwiftUI

struct MeetingView: View {
    @EnvironmentObject var currentMeeting: CurrentMeeting
    
    var body: some View {
        ZStack {
            
            let meeting = currentMeeting.meeting
            
            /*LinearGradient(
                colors: [
                    Color(hex: meeting?.layout?.colorSet?.primary ?? "a3ffff"),
                    Color(hex: meeting?.layout?.colorSet?.secondary ?? "ffa3ed"),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()*/
            
            VStack {
                List {
                    
                    Section(content: {
                        
                        Text(meeting?.getFullName() ?? "").bold().multilineTextAlignment(.center)
                        
                        LabeledContent {
                            Text(meeting?.getStartDateString() ?? "")
                        } label: {
                            Label("Start", systemImage: "calendar")
                        }
                        
                        LabeledContent {
                            Text(meeting?.getEndDateString() ?? "")
                        } label: {
                            Label("Ende", systemImage: "calendar")
                        }
                        
                        LabeledContent {
                            Text(meeting?.state ?? "lade Status...")
                        } label: {
                            Label("Status", systemImage: "dot.radiowaves.right")
                        }
                        
                        LabeledContent {
                            Text("")
                        } label: {
                            Label("Veranstalter", systemImage: "person.2.fill")
                        }
                        
                        LabeledContent {
                            Text("")
                        } label: {
                            Label("Addresse", systemImage: "mappin.and.ellipse")
                        }
                    }, header: {
                        HStack {
                            Spacer()
                            
                            ZStack {
                                Circle().fill(.white).frame(width: 150, height: 150)
                                AsyncImage(url: URL(string: meeting?.layout?.logoUrl ?? "")) {
                                    image in image.image?.resizable().aspectRatio(contentMode: .fit).clipShape(Circle())
                                }.frame(width: 120, height: 120)
                            }
                            
                            Spacer()
                        }
                        .padding()
                    })
                }
            }
        }
    }
}

#Preview {
    MeetingView().environmentObject(CurrentMeeting.example())
}
