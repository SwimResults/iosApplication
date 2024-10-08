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
            if (viewModel.loggedIn == nil) {
                Text("-= NOT LOGGED IN =-")
            } else if (viewModel.loggedIn == true) {
                Text("LOGGED IN!!")
            } else {
                Text("LOGIN FAILED!!")
            }
            if (viewModel.name != nil) {
                Text(viewModel.name!)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
        }
        .onAppear {
            viewModel.appDelegate = appDelegate
        }
        .navigationTitle(viewModel.name ?? "Test Login")
    }
}

#Preview {
    TestLoginView()
}
