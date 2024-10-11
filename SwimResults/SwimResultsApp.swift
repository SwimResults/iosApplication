//
//  SwimResultsApp.swift
//  SwimResults
//
//  Created by Konrad Weiß on 02.05.24.
//

import SwiftUI

@main
struct SwimResultsApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            MainScreenView()
//                .onAppear(perform: {
//                    // this makes sure that we are setting the app to the app delegate as soon as the main view appears
//                    appDelegate.app = self
//                })
        }
    }
}
