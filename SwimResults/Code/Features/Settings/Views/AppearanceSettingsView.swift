//
//  AppearanceSettingsView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 16.08.24.
//

import SwiftUI

enum Theme: String, CaseIterable {
    case systemDefault = "Default"
    case light = "Light"
    case dark = "Dark"
    
    var colorScheme: ColorScheme? {
        switch self {
        case .systemDefault:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

struct AppearanceSettingsView: View {
    @Environment(\.colorScheme) private var scheme
    @AppStorage("CURRENT_THEME") private var currentTheme: Theme = .systemDefault
    
    var body: some View {
        Form {
            Picker("Farbschema", selection: $currentTheme) {
                ForEach(Theme.allCases, id: \.rawValue) { theme in
                    Text(theme.rawValue)
                        .tag(theme)
                }
            }
        }
        .navigationTitle("Erscheinungsbild")
    }
}

#Preview {
    AppearanceSettingsView()
}
