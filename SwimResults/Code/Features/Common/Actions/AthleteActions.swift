//
//  AthleteActions.swift
//  SwimResults
//
//  Created by Konrad Weiß on 13.07.24.
//

import Foundation

func getAthletesByMeeting(meetId: String) async throws -> [AthleteModel] {
    do {
        return try await athleteService.get(path: "athlete/meet/" + meetId)
    } catch {
        throw error
    }
}
