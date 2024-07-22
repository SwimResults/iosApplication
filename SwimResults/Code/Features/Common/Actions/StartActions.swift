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
