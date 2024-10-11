//
//  TestLoginViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 07.10.24.
//

import Foundation
import AppAuth
import JWTDecode

@MainActor
final class TestLoginViewModel: UIViewController, ObservableObject {
    // property of the containing class
    @Published var authState: OIDAuthState?
    @Published var loggedIn: Bool?
    @Published var name: String?
    var appDelegate: AppDelegate?
    
    let clientId: String = "ios-pkce-client"
    let clientSecret: String = ""
    let redirectURI: URL = URL(string: "swimresults://oauth2redirect/keycloak-provider")!
    
    func setAuthState(state: OIDAuthState?) {
        self.authState = state
    }
    
    private func getHostingViewController() -> UIViewController {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene!.keyWindow!.rootViewController!
    }
    
    func login() {
        
        self.loggedIn = nil
        
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
                    self.loggedIn = true
                    self.fetchUserName(authState: authState)
                } else {
                    print("Authorization error: \(error?.localizedDescription ?? "Unknown error")")
                    self.setAuthState(state: nil)
                    self.loggedIn = false
                }
            }
        } // discoverConfiguration
    }
    
    func fetchUserName(authState: OIDAuthState) {
        authState.performAction() { (accessToken, idToken, error) in
            
            if error != nil  {
                print("Error fetching fresh tokens: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            guard let accessToken = accessToken else {
                return
            }
            
            do {
                let jwt = try decode(jwt: accessToken)
                self.name = jwt.claim(name: "name").string
            } catch {
               print("decoding jwt failed")
               return
            }
            
            
        }
    }
}
    
