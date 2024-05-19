//
//  MainMeetingListView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import SwiftUI

struct MainMeetingListView: View {
    @ObservedObject private var viewModel = MainMeetingListViewModel()
    @EnvironmentObject var currentMeeting: CurrentMeeting
    
    @Binding var sheetMode: SheetMode

    var body: some View {
        VStack {
            ZStack {
                
                List {
                    
                    ForEach(viewModel.meetingYearList, id: \.self) { meetingYear in
                        
                        Text(String(meetingYear.year)).font(.title).bold()
                        
                        Section {
                            
                            ForEach(meetingYear.meetings, id: \.self) { meeting in
                                
                                Button {
                                    currentMeeting.meeting = meeting
                                    sheetMode = .none
                                } label: {
                                    Label(meeting.getFullName(), systemImage: "calendar")
                                }.foregroundColor(.primary)
                            }
                            
                        }
                    }
                }
                .refreshable {
                    await viewModel.fetchMeetings()
                }
                
                if viewModel.fetching {
                        SpinnerView()
                }
            }
        }
        .task {
            await viewModel.fetchMeetings()
        }
    }
}

#Preview {
    MainMeetingListView(sheetMode: .constant(SheetMode.meetingSelection))
}
