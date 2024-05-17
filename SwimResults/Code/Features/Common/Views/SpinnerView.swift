//
//  SpinnerView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 06.05.24.
//

import SwiftUI

struct SpinnerView: View {
    var text: String = "";
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
            
            if (text != "") {
                Text(text)
            }
        }
    }
    
    init(_ text: String = "") {
        self.text = text
    }
}

#Preview {
    SpinnerView()
}
