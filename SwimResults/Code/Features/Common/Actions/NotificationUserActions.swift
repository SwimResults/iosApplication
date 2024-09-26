//
//  NotificationUserService.swift
//  SwimResults
//
//  Created by Konrad Weiß on 21.09.24.
//

import Foundation

func registerNotificationUser(_ token: String) async throws -> NotificationUserModel {
    let dto = NotificationRegisterUserRequestDto(token: token)
    do {
        return try await userService.post(path: "notification_user/register", params: [:], data: dto)
    } catch {
        throw error
    }
}
