//
//  StartListView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 11.05.24.
//

import SwiftUI

struct StartListView: View {
    @ObservedObject private var viewModel = StartListViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.fetching {
                SpinnerView()
            } else {
                
            }
        }
    }
}

#Preview {
    StartListView()
}
