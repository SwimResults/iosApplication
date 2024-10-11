//
//  LoginView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 09.10.24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    @EnvironmentObject var authState: AuthState
    @ObservedObject private var viewModel = LoginViewModel()
    @Binding var showSheet: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Melde dich mit deinem SwimResults Account an, um personalisierte Informationen sehen zu können.")
                Spacer()
                Button {
                    Task {
                        viewModel.login()
                    }
                } label: {
                    Text("Login")
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.extraLarge)
            }
            .onAppear {
                viewModel.appDelegate = appDelegate
                viewModel.authState = authState
            }
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Anmelden").font(.title)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {showSheet = false}) {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .font(.title2)
                    }
                }
            }
        }
        .backgroundStyle(.windowBackground)
    }
}

#Preview {
    LoginView(showSheet: Binding.constant(true))
}
