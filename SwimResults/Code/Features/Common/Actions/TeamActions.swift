//
//  TeamActions.swift
//  SwimResults
//
//  Created by Konrad Weiß on 16.08.24.
//

import Foundation

func getTeamById(_ id: String) async throws -> TeamModel {
    do {
        return try await athleteService.get(path: "team/" + id)
    } catch {
        throw error
    }
}
