//
//  StartListConfig.swift
//  SwimResults
//
//  Created by Konrad Weiß on 25.07.24.
//

import Foundation

struct StartListConfig {
    
    public init() {}
    
    public init(showAthlete: Bool = false, showEvent: Bool = false, showStyle: Bool = false, showHeat: Bool = false, showLane: Bool = false, showTimes: Bool = false, showRegistrationTime: Bool = false, showResults: Bool = false, showResultTime: Bool = false, showLapTimes: Bool = false, showLapTimesPopup: Bool = false, showDisqualification: Bool = false, showReactionTime: Bool = false, showMostSignificantTime: Bool = false, laneAsIcon: Bool = false, showIcon: Bool = false, flatStyle: Bool = false, allLanes: Bool = false, rankStylesIcon: Bool = false, widgetSize: Bool = false) {
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
    var showAthlete: Bool = false
    var showEvent: Bool = false;
    var showStyle: Bool = false;
    var showHeat: Bool = false;
    var showLane: Bool = false;
    var showIcon: Bool = false;
    var laneAsIcon: Bool = false;
    var rankStylesIcon: Bool = false;
    var showTimes: Bool = false;
    var showRegistrationTime: Bool = false;
    
    
    // FROM WebApplication (https://github.com/SwimResults/WebApplication)
    var showResults: Bool = false;
    var showResultTime: Bool = false;
    var showLapTimes: Bool = false;
    var showLapTimesPopup: Bool = false;
    var showDisqualification: Bool = false;
    var showReactionTime: Bool = false;
    var showMostSignificantTime: Bool = false; // show either registration; reaction; lap; livetiming result OR result list result time
    var flatStyle: Bool = false;
    var allLanes: Bool = false;
    var widgetSize: Bool = false;
}
