//
//  TravelTimetableApp.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 29.02.2024.
//

import SwiftUI

@main
struct TravelTimetableApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MainView()
                    .tabItem {
                        Image(systemName: "arrow.up.message.fill")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                    }
            }
        }
    }
}
