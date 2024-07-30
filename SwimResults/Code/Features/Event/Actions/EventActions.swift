//
//  EventActions.swift
//  SwimResults
//
//  Created by Konrad Weiß on 08.05.24.
//

import Foundation

func getEventsAsPartsByMeetId(_ meeting: String) async throws -> [MeetingPartModel] {
    do {
        return try await meetingService.get(path: "event/meet/" + meeting + "/parts")
    } catch {
        throw error
    }
}

func getEventsByMeeting(_ meetingId: String) async throws -> [EventModel] {
    do {
        return try await meetingService.get(path: "event/meet/" + meetingId)
    } catch {
        throw error
    }
}

func getEventByMeetingAndNumber(_ meetingId: String, _ number: Int) async throws -> EventModel {
    do {
        return try await meetingService.get(path: "event/meet/" + meetingId + "/event/" + String(number))
    } catch {
        throw error
    }
}

func getHeatsByMeetingForEventList(_ meetingId: String) async throws -> EventListInfoModel {
    do {
        return try await startService.get(path: "heat/meet/" + meetingId + "/event_list")
    } catch {
        throw error
    }
}
