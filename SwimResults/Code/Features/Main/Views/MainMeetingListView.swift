//
//  MainMeetingListView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import SwiftUI

struct MainMeetingListView: View {
    @StateObject private var viewModel = MainMeetingListViewModel()
    @EnvironmentObject var currentMeeting: CurrentMeeting
    
    @Binding var sheetMode: SheetMode

    var body: some View {
        VStack {
            ZStack {
                
                List {
                    
                    ForEach(viewModel.meetingYearList, id: \.self) { meetingYear in
                        
                        Section {
                            
                            ForEach(meetingYear.meetings, id: \.self) { meeting in
                                
                                Button {
                                    currentMeeting.meeting = meeting
                                    sheetMode = .none
                                } label: {
                                    Label {
                                        VStack(alignment: .leading) {
                                            Text(meeting.getFullName())
                                                .bold()
                                            Text("\(meeting.getStartDateString()) bis \(meeting.getEndDateString())")
                                                .font(.caption)
                                        }
                                    } icon: {
                                        Image(systemName: "calendar")
                                            .foregroundStyle(.blue)
                                    }
                                }.foregroundColor(.primary)
                            }
                            
                        } header: {
                            Text(String(meetingYear.year))
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
