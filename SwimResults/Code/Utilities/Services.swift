//
//  Services.swift
//  SwimResults
//
//  Created by Konrad Weiß on 08.05.24.
//

import Foundation

var meetingService: ApiActions = ApiActions(url: "https://api.swimresults.de/meeting/v1/")
var startService: ApiActions = ApiActions(url: "https://api.swimresults.de/start/v1/")
var athleteService: ApiActions = ApiActions(url: "https://api.swimresults.de/athlete/v1/")
var userService: ApiActions = ApiActions(url: "https://api.swimresults.de/user/v1/")

func useDevServer(_ use: Bool) {
    if (use) {
        meetingService = ApiActions(url: "https://api-dev.swimresults.de/meeting/v1/")
        startService = ApiActions(url: "https://api-dev.swimresults.de/start/v1/")
        athleteService = ApiActions(url: "https://api-dev.swimresults.de/athlete/v1/")
        userService = ApiActions(url: "https://api-dev.swimresults.de/user/v1/")
    } else {
        meetingService = ApiActions(url: "https://api.swimresults.de/meeting/v1/")
        startService = ApiActions(url: "https://api.swimresults.de/start/v1/")
        athleteService = ApiActions(url: "https://api.swimresults.de/athlete/v1/")
        userService = ApiActions(url: "https://api.swimresults.de/user/v1/")
    }
}
