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
        Text(currentMeeting.meeting!.getFullName())
    }
}

#Preview {
    MeetingView()
}
