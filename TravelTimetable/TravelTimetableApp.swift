//
//  TravelTimetableApp.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 29.02.2024.
//

import SwiftUI

@main
struct TravelTimetableApp: App {
    enum State {
        case splashScreen
        case loaded
    }
    
    let cityManager = CityManager()
    let colorSchemeManager = ColorSchemeManager()
    
    var viewState: State = .loaded

    var body: some Scene {
        WindowGroup {
            switch viewState {
            case .splashScreen:
                SplashScreen()
            case .loaded:
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
}
