//
//  ColorSchemeManager.swift
//  TravelTimetable
//
//  Created by Vadim on 03.05.2024.
//

import Foundation
import SwiftUI

protocol ColorSchemeManagerProtocol {
    var currentColorScheme: ColorScheme { get }
    
    func setColorScheme(_ scheme: ColorScheme)
    func toggleColorScheme()
}

final class ColorSchemeManager: ColorSchemeManagerProtocol {
    @Published private(set) var currentColorScheme: ColorScheme = .light
    
    func setColorScheme(_ scheme: ColorScheme) {
        currentColorScheme = scheme
    }
    
    func toggleColorScheme() {
        if currentColorScheme == .light {
            currentColorScheme = .dark
        } else {
            currentColorScheme = .light
        }
    }
}
