//
//  SettingViewModel.swift
//  TravelTimetable
//
//  Created by Vadim on 03.05.2024.
//

import Foundation

final class SettingViewModel {
    private(set) var colorToogleIsOn: Bool
    
    private var colorSchemeManager: ColorSchemeManagerProtocol
    
    init(colorSchemeManager: ColorSchemeManagerProtocol) {
        self.colorSchemeManager = colorSchemeManager
        colorToogleIsOn = colorSchemeManager.currentColorScheme == .light ? false : true
    }
    
    func setColorScheme(_ enabled: Bool) {
        colorSchemeManager.setColorScheme(enabled ? .dark : .light)
        colorToogleIsOn = colorSchemeManager.currentColorScheme == .light ? false : true
    }
}
