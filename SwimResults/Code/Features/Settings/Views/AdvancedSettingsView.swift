//
//  AdvancedSettingsView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 23.07.24.
//

import SwiftUI

struct AdvancedSettingsView: View {
    @AppStorage("USE_DEV_SERVER") var isDevServer: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Toggle("Dev Server verwenden", isOn: $isDevServer)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    .onChange(of: isDevServer) {
                        useDevServer(isDevServer)
                    }
            }
        }
        .navigationTitle("Erweiterte Einstellungen")
    }
}

#Preview {
    AdvancedSettingsView()
}
