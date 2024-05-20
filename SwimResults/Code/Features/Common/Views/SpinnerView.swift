//
//  SpinnerView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 06.05.24.
//

import SwiftUI

struct Sheetly: View {
    @State private var showingFirst = true
    @State private var showingThird = false

    var body: some View {
        VStack {
            Button("Show First Sheet") {
                showingFirst = true
            }
            Button("Show Full Screen Cover") {
                showingThird = true
            }
            Spacer()
        }
        .sheet(isPresented: $showingFirst) {
            Button("Show Full Screen Cover") {
                showingFirst = false
                showingThird = true
            }
            .presentationDetents([.medium, .large])
            .presentationBackgroundInteraction(.enabled)
        }
        .fullScreenCover(isPresented: $showingThird) {
            VStack {
                Text("Full Screen Cover")
                Button(action: {showingThird = false; showingFirst = true}) {
                    Text("Close")
                }
            }
        }
    }
}

struct SpinnerView: View {
    var text: String = "";
    var inline: Bool = false;
    var body: some View {
        VStack {
            if (!inline) {
                Spacer()
            }
            ProgressView()
                .scaleEffect(1.5)
                .padding()
            
            if (text != "") {
                Text(text)
            }
            if (!inline) {
                Spacer()
            }
        }
    }
    
    init(_ text: String = "") {
        self.text = text
    }
}

#Preview {
    //SpinnerView("Läuft doch")
    Sheetly()
}
