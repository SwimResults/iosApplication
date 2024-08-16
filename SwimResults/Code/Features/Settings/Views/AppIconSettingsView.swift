//
//  AppIconSettingsView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 16.08.24.
//

import SwiftUI

struct AppIconSettingsView: View {
    enum AppIcon: String, CaseIterable, Identifiable {
        case dark = "AppIcon Dark"
        case light = "AppIcon Light"
        case coloured = "AppIcon Coloured"
        
        var id: Self { self }
    }

    @State private var currentAppIcon: String = UIApplication.shared.alternateIconName ?? AppIcon.dark.rawValue

    
    func changeIcon(_ iconName: String) {
        UIApplication.shared.setAlternateIconName(iconName) { (error) in
            if let error = error {
                print("Failed request to update the app’s icon: \(error)")
            } else {
                currentAppIcon = iconName
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(AppIcon.allCases, id: \.rawValue) { item in
                Button {
                    changeIcon(item.rawValue)
                } label: {
                    HStack(spacing:20) {
                        Image(uiImage: UIImage(named: item.rawValue) ?? UIImage())
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 50, height: 50, alignment: .leading)
                            .cornerRadius(10)
                        Text(item.rawValue)
                        Spacer()
                        if (currentAppIcon == item.rawValue) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                    }
                }.buttonStyle(.plain)
            }
        }.navigationTitle("App Icon")
    }
}

#Preview {
    NavigationStack {
        AppIconSettingsView()
    }
}
