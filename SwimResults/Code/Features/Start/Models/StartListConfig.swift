//
//  StartListConfig.swift
//  SwimResults
//
//  Created by Konrad Weiß on 25.07.24.
//

import Foundation

class StartListConfig {
    // USED
    
    
    // FROM WebApplication (https://github.com/SwimResults/WebApplication)
    var showAthlete: Bool = false
    var showEvent: Bool = false;
    var showStyle: Bool = true;
    var showHeat: Bool = true;
    var showLane: Bool = true;
    var showTimes: Bool = true;
    var showRegistrationTime: Bool = true;
    var showResults: Bool = true;
    var showResultTime: Bool = true;
    var showLapTimes: Bool = false;
    var showLapTimesPopup: Bool = false;
    var showDisqualification: Bool = true;
    var showReactionTime: Bool = true;
    var showMostSignificantTime: Bool = false; // show either registration; reaction; lap; livetiming result OR result list result time
    var laneAsIcon: Bool = false;
    var showIcon: Bool = true;
    var flatStyle: Bool = false;
    var allLanes: Bool = false;
    var rankStylesIcon: Bool = true;
    var widgetSize: Bool = false;
}
