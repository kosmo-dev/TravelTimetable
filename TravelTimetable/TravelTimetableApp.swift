//
//  TravelTimetableApp.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 29.02.2024.
//

import SwiftUI

@main
struct TravelTimetableApp: App {
    let cityManager = CityManager()
    let colorSchemeManager = ColorSchemeManager()

    var body: some Scene {
        WindowGroup {
            TabView {
                MainView(viewModel: MainViewViewModel(cityManager: cityManager))
                    .tabItem {
                        Image(systemName: "arrow.up.message.fill")
                    }
                    .environment(\.colorScheme, colorSchemeManager.currentColorScheme)
                SettingsView(viewModel: SettingViewModel(colorSchemeManager: colorSchemeManager))
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                    }
                    .environment(\.colorScheme, colorSchemeManager.currentColorScheme)
            }
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .ypWhiteDL
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
            .tint(.ypBlackDL)
        }
    }
}
