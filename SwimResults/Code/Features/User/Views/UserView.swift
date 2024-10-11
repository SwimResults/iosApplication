//
//  UserView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 13.07.24.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var authState: AuthState
    @State var showLoginSheet: Bool = false
    
    var body: some View {
        VStack {
            if (authState.loggedIn) {
                Text("Willkommen zurück!")
            } else {
                VStack {
                    Text("Nicht angemeldet!")
                    Button {
                        showLoginSheet = true
                    } label: {
                        Text("Bei SwimResults anmelden")
                    }
                }
            }
        }
        .sheet(isPresented: $showLoginSheet) {
            LoginView(showSheet: $showLoginSheet)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    UserView()
}
