//
//  StartView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 22.07.24.
//

import SwiftUI

struct StartView: View {
    public var startId: String
    
    @ObservedObject private var viewModel = StartViewModel(startId: startId)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    StartView(startId: "")
}
