//
//  LiveBarViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 08.06.24.
//

import Foundation

@MainActor
final class LiveBarViewModel: ObservableObject {
    @Published var currentMeeting: CurrentMeeting?
    @Published var fetching = false
    
    @Published var currentHeat: HeatModel?
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
    }
    
    func fetchCurrentHeat(_ meetId: String) async {
        do {
            fetching = true
            currentHeat = try await getCurrentHeatByMeetingId(meetId)
            if ((currentHeat) != nil) {
                print(currentHeat ?? HeatModel.init(_id: "", meeting: ""))
            } else {
                print("no heat data")
            }
        } catch {
            
        }
        fetching = false
    }
}
