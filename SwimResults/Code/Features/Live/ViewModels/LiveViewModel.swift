//
//  LiveViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.10.24.
//

import Foundation

@MainActor
final class LiveViewModel: ObservableObject {
    
    @Published var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    @Published var currentMeeting: CurrentMeeting?
    
    @Published var fetchingStarts = false
    @Published var fetchingHeat = false
    @Published var fetchingEvent = false
    
    @Published var firstLane: Int = 1
    @Published var numOfLanes: Int = 8
    
    @Published var isLive: Bool = true
    
    @Published var currentEvent: Int = 1
    @Published var currentHeat: Int = 1
    
    @Published var starts: [StartModel] = []
    @Published var heat: HeatModel?
    @Published var event: EventModel?
    @Published var numOfHeats: Int = 1
    @Published var heatFinished: Bool = false
    
    @Published var config: StartListConfig = StartListConfig(
        showAthlete: true,
        showResults: true,
        showMostSignificantTime: true,
        laneAsIcon: true,
        showIcon: true,
        flatStyle: true,
        allLanes: true
    )
    
    func setup(_ currentMeeting: CurrentMeeting) {
        self.currentMeeting = currentMeeting
        self.firstLane = currentMeeting.meeting?.location?.firstLane ?? 1
        self.numOfLanes = currentMeeting.meeting?.location?.lanes ?? 8
    }
    
    func fetchData() async {
        await self.fetchHeat()
        await self.fetchEvent()
    }
    
    func fetchHeat() async {
        guard let meetId = currentMeeting?.meetingId else { return }
        fetchingHeat = true
        do {
            if (isLive) {
                starts = try await getCurrentStartsByMeetingId(meetId)
            } else {
                starts = try await getStartsByMeetingAndEventAndHeat(meetId, self.currentEvent, self.currentHeat)
            }
            
            processStarts(starts)
        } catch {
            
        }
        fetchingHeat = false
    }
    
    func processStarts(_ starts: [StartModel]) {
        heatFinished = false
        self.starts = []
        var lanes: [StartModel] = []
        
        for start in starts {
            if (start.hasResult()) {
                heatFinished = true
            } 
            //                               2        // 4 -> 5           7? -> 7 - 2 +1 = 6
            // if there is a lane that is higher than the expected highest lane, increase number of lanes
            if (start.lane != nil && start.lane! > firstLane + numOfLanes - 1) {
                numOfLanes = start.lane! - firstLane + 1
            }
        }
        
        if (starts.count > 0) {
            let s1 = starts[0]
            if (isLive) {
                currentEvent = s1.event ?? 1
                currentHeat = s1.heatNumber ?? 1
                
                // during life, heat is only shown as finished, if all starts are over and heat is finished
                
                heatFinished = heat?.isFinished() ?? false
            }
            
            self.heat = s1.heat
        }
        
        if (isLive) {
            Task {
                await fetchEvent()
                await fetchHeatAmount()
            }
        }
        //          2           4           2 = 6
        for i in firstLane...numOfLanes + firstLane - 1 {
            lanes.append(StartModel(_id: "", meeting: "", lane: i, results: [], emptyLane: true))
        }
        
        for start in starts {
            if (start.lane != nil) {
                lanes[start.lane! - firstLane] = start
            }
        }
        
        // sort by result if heat is finished
        if (heatFinished) {
            
        }
        
        config.laneAsIcon =             !heatFinished
        config.allLanes =               !heatFinished
        config.showRegistrationTime =   !heatFinished
        config.showResultTime =         !heatFinished
        config.showMostSignificantTime = isLive
        
        self.starts = lanes
        
        
        // angular

//        if (this.heatFinished) {
//            ls.sort((a, b) => (a.emptyLane ? 1 : (b.emptyLane ? -1 : (a.getResultMilliseconds() <= 0 ? 1 : (b.getResultMilliseconds() <= 0 ? -1 : a.getResultMilliseconds() - b.getResultMilliseconds())))))
//            let j = 1;
//            for (let start of ls) {
//                start.rank = j++;
//            }
//        }
    }
    
    func fetchEvent() async {
        guard let meetId = currentMeeting?.meetingId else { return }
        guard let eventId = heat?.event else { return }
        
        fetchingEvent = true
        do {
            let event = try await getEventByMeetingAndNumber(meetId, eventId)
            
            self.event = event
            
            fetchingEvent = false
        } catch {
            print(error)
            fetchingEvent = false
        }
    }
    
    func fetchHeatAmount() async {
        
    }
}
