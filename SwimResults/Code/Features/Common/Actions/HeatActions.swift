//
//  HeatActions.swift
//  SwimResults
//
//  Created by Konrad Weiß on 08.06.24.
//

import Foundation

func getCurrentHeatByMeetingId(_ meetId: String) async throws -> HeatModel {
    do {
        return try await startService.get(path: "heat/meet/" + meetId + "/current")
    } catch {
        throw error
    }
}
