//
//  AuthState.swift
//  SwimResults
//
//  Created by Konrad Weiß on 09.10.24.
//

import Foundation
import AppAuthCore
import JWTDecode

class AuthState: ObservableObject, Observable {
    @Published var oidAuthState: OIDAuthState?
    @Published var loggedIn: Bool = false
    @Published var userData: JWT?
}
