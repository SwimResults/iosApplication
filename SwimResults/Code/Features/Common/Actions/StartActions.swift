//
//  StartActions.swift
//  SwimResults
//
//  Created by Konrad Weiß on 22.07.24.
//

import Foundation

func getStartById(_ id: String) async throws -> StartModel {
    do {
        return try await startService.get(path: "start/" + id)
    } catch {
        throw error
    }
}

func getStartsByAthlete(_ athleteId: String) async throws -> [StartModel] {
    do {
        return try await startService.get(path: "start/athlete/" + athleteId)
    } catch {
        throw error
    }
}

func getStartsByMeetingAndAthlete(_ meeting: String, _ athleteId: String) async throws -> [StartModel] {
    do {
        return try await startService.get(path: "start/meet/" + meeting + "/athlete/" + athleteId)
    } catch {
        throw error
    }
}

func getStartsByMeetingAndEvent(_ meeting: String, _ eventNumber: Int) async throws -> [StartModel] {
    do {
        return try await startService.get(path: "start/meet/" + meeting + "/event/\(eventNumber)")
    }
}

func getStartsByMeetingAndEventAsResults(_ meeting: String, _ eventNumber: Int) async throws -> [EventAgeResultModel] {
    do {
        return try await startService.get(path: "start/meet/" + meeting + "/event/\(eventNumber)/results")
    }
}
