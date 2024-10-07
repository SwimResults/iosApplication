//
//  TestLoginView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 07.10.24.
//

import SwiftUI

struct TestLoginView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    @ObservedObject private var viewModel = TestLoginViewModel()

    var body: some View {
        Form {
            Button {
                Task {
                    viewModel.login()
                }
            } label: {
                Text("Login")
            }
        }
        .onAppear {
            viewModel.appDelegate = appDelegate
        }
    }
}

#Preview {
    TestLoginView()
}
