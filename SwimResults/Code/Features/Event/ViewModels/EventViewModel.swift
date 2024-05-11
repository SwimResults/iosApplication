//
//  EventViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import Foundation

final class EventViewModel: ObservableObject {
    @Published var fetching = false
    
    var currentMeeting: CurrentMeeting?
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
    }
}
