//
//  MainViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var meeting: MeetingModel?
    
    @Published var selection = 1
    
    func getMeetingByMeetId(_ meetId: String) {
        
    }
}
