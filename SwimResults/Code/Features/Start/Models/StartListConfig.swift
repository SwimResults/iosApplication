//
//  StartListConfig.swift
//  SwimResults
//
//  Created by Konrad Weiß on 25.07.24.
//

import Foundation

class StartListConfig {
    
    public init() {}
    
    public init(showAthlete: Bool = false, showEvent: Bool = false, showStyle: Bool = true, showHeat: Bool = true, showLane: Bool = true, showTimes: Bool = true, showRegistrationTime: Bool = true, showResults: Bool = true, showResultTime: Bool = true, showLapTimes: Bool = false, showLapTimesPopup: Bool = false, showDisqualification: Bool = true, showReactionTime: Bool = true, showMostSignificantTime: Bool = false, laneAsIcon: Bool = false, showIcon: Bool = true, flatStyle: Bool = false, allLanes: Bool = false, rankStylesIcon: Bool = true, widgetSize: Bool = false) {
        self.showAthlete = showAthlete
        self.showEvent = showEvent
        self.showStyle = showStyle
        self.showHeat = showHeat
        self.showLane = showLane
        self.showTimes = showTimes
        self.showRegistrationTime = showRegistrationTime
        self.showResults = showResults
        self.showResultTime = showResultTime
        self.showLapTimes = showLapTimes
        self.showLapTimesPopup = showLapTimesPopup
        self.showDisqualification = showDisqualification
        self.showReactionTime = showReactionTime
        self.showMostSignificantTime = showMostSignificantTime
        self.laneAsIcon = laneAsIcon
        self.showIcon = showIcon
        self.flatStyle = flatStyle
        self.allLanes = allLanes
        self.rankStylesIcon = rankStylesIcon
        self.widgetSize = widgetSize
    }
    
    
    
    // USED
    
    
    // FROM WebApplication (https://github.com/SwimResults/WebApplication)
    var showAthlete: Bool = false
    var showEvent: Bool = false;
    var showStyle: Bool = false;
    var showHeat: Bool = false;
    var showLane: Bool = false;
    var showTimes: Bool = false;
    var showRegistrationTime: Bool = false;
    var showResults: Bool = false;
    var showResultTime: Bool = false;
    var showLapTimes: Bool = false;
    var showLapTimesPopup: Bool = false;
    var showDisqualification: Bool = false;
    var showReactionTime: Bool = false;
    var showMostSignificantTime: Bool = false; // show either registration; reaction; lap; livetiming result OR result list result time
    var laneAsIcon: Bool = false;
    var showIcon: Bool = false;
    var flatStyle: Bool = false;
    var allLanes: Bool = false;
    var rankStylesIcon: Bool = false;
    var widgetSize: Bool = false;
}
