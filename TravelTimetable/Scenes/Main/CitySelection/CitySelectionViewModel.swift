//
//  CitySelectionViewModel.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 21.04.2024.
//

import Foundation

final class CitySelectionViewModel: ObservableObject {
    enum State {
        case loaded
        case emptySearch
    }
    
    enum Destination: Hashable {
        case stationSelection
    }

    @Published var state: State = .loaded
    @Published var searchText = ""
    @Published var visibleList: [String] {
        didSet {
            checkAndChangeState()
        }
    }
    @Published var path: [Destination] = []

    var onDismiss: () -> Void
    
    private var list: [String] = ["Москва", "Санкт-Петербург", "Сочи", "Горный Воздух", "Краснодар", "Казань", "Омск"]
    private var selectedCity: String = ""

    private var cityManager: CityManagerProtocol
    private var cityType: CityType

    init(cityManager: CityManagerProtocol, cityType: CityType, onDismiss: @escaping () -> Void) {
        self.cityManager = cityManager
        self.cityType = cityType
        self.onDismiss = onDismiss
        visibleList = list
    }

    func performSearch(text: String) {
        searchText = text
        
        guard text != "" else {
            visibleList = list
            return
        }
        visibleList = list.filter { $0.lowercased().contains(text.lowercased()) }
    }

    func checkAndChangeState() {
        if visibleList.isEmpty {
            state = .emptySearch
        } else {
            state = .loaded
        }
    }
    
    func showStationSelection(selectedCity: String) {
        cityManager.setCity(selectedCity, type: cityType)
        self.selectedCity = selectedCity
        path.append(.stationSelection)
    }
    
    func makeStationSelectionViewModel() -> StationSelectionViewModel {
        StationSelectionViewModel(cityManager: cityManager, cityType: cityType, onDismiss: onDismiss)
    }
}
