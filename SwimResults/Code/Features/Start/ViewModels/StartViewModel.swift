//
//  StartViewModel.swift
//  SwimResults
//
//  Created by Konrad Weiß on 22.07.24.
//

import Foundation

@MainActor
final class StartViewModel: ObservableObject {
    @Published var start: StartModel?
    @Published var fetching = false
    
    public var startId: String?
    
    init(startId: String) {
        self.startId = startId
    }
    
    func fetchStart() async {
        if (startId == nil) {
            return
        }
        
        fetching = true
        do {
            let start = try await getStartById(startId!)
            
            self.start = start
            
            fetching = false
        } catch {
            print(error)
            fetching = false
        }
    }
    
}


