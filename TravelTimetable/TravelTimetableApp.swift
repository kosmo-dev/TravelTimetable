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
    let storiesManager = StoriesManager()
    let networkRequest = NetworkRequest()

    var viewState: State = .loaded
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    var body: some Scene {
        WindowGroup {
            switch viewState {
            case .splashScreen:
                SplashScreen()
            case .loaded:
                TabView {
                    MainView(viewModel: MainViewViewModel(cityManager: cityManager, storiesManager: storiesManager, networkRequest: networkRequest))
                        .tabItem {
                            Image(systemName: "arrow.up.message.fill")
                        }
                        .modifier(DarkModeViewModifier())
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gearshape.fill")
                        }
                        .modifier(DarkModeViewModifier())
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

public struct DarkModeViewModifier: ViewModifier {

    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    public func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
