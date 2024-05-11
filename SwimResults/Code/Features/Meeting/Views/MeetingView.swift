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
            
            VStack(spacing: 20) {
                ZStack {
                    Circle().fill(.white).frame(width: 150, height: 150)
                    AsyncImage(url: URL(string: meeting?.layout?.logoUrl ?? "")) {
                        image in image.image?.resizable().aspectRatio(contentMode: .fit).clipShape(Circle())
                    }.frame(width: 120, height: 120)
                }
                GroupBox {
                    Text(meeting?.getFullName() ?? "").bold().multilineTextAlignment(.center)
                    Divider()
                    Text("vom " + (meeting?.getStartDateString() ?? ""))
                    Text("bis " + (meeting?.getEndDateString() ?? ""))
                    Divider()
                    HStack {
                        Text("Status: ").bold()
                        Text(meeting?.state ?? "lade Status...")
                    }
                    HStack {
                        Text("Veranstalter: ").bold()
                        //Text(team?.name ?? "-")
                    }
                }
                .padding()
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    MeetingView().environmentObject(CurrentMeeting.example())
}
