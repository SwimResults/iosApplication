//
//  LoginViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 09.10.24.
//

import Foundation
import AppAuth
import JWTDecode

@MainActor
final class LoginViewModel: UIViewController, ObservableObject {
    // property of the containing class
    var authState: AuthState?
    var appDelegate: AppDelegate?
    
    let clientId: String = "ios-pkce-client"
    let clientSecret: String = ""
    let redirectURI: URL = URL(string: "swimresults://oauth2redirect/keycloak-provider")!
    
    func setAuthState(state: OIDAuthState?) {
        self.authState?.oidAuthState = state
    }
    
    private func getHostingViewController() -> UIViewController {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene!.keyWindow!.rootViewController!
    }
    
    func login() {
        
        let issuer = URL(string: "https://auth.swimresults.de/realms/swimresults")!
        
        // discovers endpoints
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { configuration, error in
            guard let config = configuration else {
                print("Error retrieving discovery document: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // perform the auth request...
            // builds authentication request
            let request = OIDAuthorizationRequest(configuration: config,
                                                  clientId: self.clientId,
                                                  clientSecret: self.clientSecret,
                                                  scopes: [OIDScopeOpenID, OIDScopeProfile],
                                                  redirectURL: self.redirectURI,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: nil)
            
            // performs authentication request
            print("Initiating authorization request with scope: \(request.scope ?? "nil")")
            
            if (self.appDelegate == nil) {
                print("Error accessing AppDelegate")
                return
            }
            
            self.appDelegate!.currentAuthorizationFlow =
            OIDAuthState.authState(byPresenting: request, presenting: self.getHostingViewController()) { authState, error in
                if let authState = authState {
                    self.setAuthState(state: authState)
                    print("Got authorization tokens. Access token: " +
                          "\(authState.lastTokenResponse?.accessToken ?? "nil")")
                } else {
                    print("Authorization error: \(error?.localizedDescription ?? "Unknown error")")
                    self.setAuthState(state: nil)
                }
            }
        } // discoverConfiguration
    }
}
