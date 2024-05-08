//
//  MeetingActions.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import Foundation

func getMeetings() async throws -> [MeetingModel] {
    do {
        return try await meetingService.get(path: "meeting")
    } catch {
        throw error
    }
}

func getMeetingByMeetId(_ meetId: String) async throws -> MeetingModel {
    do {
        return try await meetingService.get(path: "meeting/meet/" + meetId)
    } catch {
        throw error
    }
}
