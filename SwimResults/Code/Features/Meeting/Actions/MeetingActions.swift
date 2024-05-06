//
//  MeetingActions.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import Foundation

let api: ApiActions = ApiActions(url: "https://api.swimresults.de/meeting/v1/")

func getMeetings() async throws -> [MeetingModel] {
    do {
        return try await api.get(path: "meeting")
    } catch {
        throw error
    }
}

func getMeetingByMeetId(_ meetId: String) async throws -> MeetingModel {
    do {
        return try await api.get(path: "meeting/meet/" + meetId)
    } catch {
        throw error
    }
}
