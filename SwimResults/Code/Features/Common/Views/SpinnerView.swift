//
//  SpinnerView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 06.05.24.
//

import SwiftUI

struct SpinnerView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(1.5)
    }
}

#Preview {
    SpinnerView()
}
