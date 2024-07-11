//
//  EventView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var currentMeeting: CurrentMeeting
    
    @ObservedObject private var viewModel = EventViewModel()
    var meetingEvent: EventModel;
    
    var body: some View {
        ZStack {
            
            if viewModel.fetching {
                SpinnerView()
            } else {
                VStack {
                    Text(meetingEvent.getEventName())
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.setup(currentMeeting)
        }
        .navigationTitle(Text("Wettkampf \(meetingEvent.number)"))
    }
}

#Preview {
    EventView(meetingEvent: EventModel(_id: "", number: 10, distance: 50, meeting: "IESC23", gender: "MALE")).environmentObject(CurrentMeeting.example())
}
