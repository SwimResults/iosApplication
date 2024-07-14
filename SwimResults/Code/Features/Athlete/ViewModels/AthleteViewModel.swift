//
//  AthleteViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 14.07.24.
//

import Foundation

final class AthleteViewModel: ObservableObject {
    @Published var fetching = false
    
    var currentMeeting: CurrentMeeting?
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
    }
}
