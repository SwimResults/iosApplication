//
//  MainMeetingListView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import SwiftUI

struct MainMeetingListView: View {
    @ObservedObject private var viewModel = MainMeetingListViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                
                List {
                    
                    ForEach(viewModel.meetingYearList, id: \.self) { meetingYear in
                        
                        Text(String(meetingYear.year)).font(.title).bold()
                        
                        Section {
                            
                            ForEach(meetingYear.meetings, id: \.self) { meeting in
                                
                                Button {
                                    
                                } label: {
                                    Label(meeting.getFullName(), systemImage: "calendar")
                                }.foregroundColor(.primary)
                            }
                            
                        }
                    }
                }
                
                if viewModel.fetching {
                        SpinnerView()
                }
            }
        }
        .onAppear(perform: {
            viewModel.fetchMeetings()
        })
    }
}

#Preview {
    MainMeetingListView()
}
