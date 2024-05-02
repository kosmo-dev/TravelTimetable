//
//  StationSelectionViewModel.swift
//  TravelTimetable
//
//  Created by Vadim on 23.04.2024.
//

import Foundation

final class StationSelectionViewModel: ObservableObject {
    enum State {
        case loaded
        case emptySearch
    }
    
    @Published var state: State = .loaded
    @Published var searchText = ""
    @Published var visibleList: [String] {
        didSet {
            checkAndChangeState()
        }
    }
    private var list: [String] = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    
    var onDismiss: () -> Void

    private var cityManager: CityManagerProtocol
    private var cityType: CityType

    init(cityManager: CityManagerProtocol, cityType: CityType, onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
        self.cityManager = cityManager
        self.cityType = cityType
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

    func chooseStaion(_ station: String) {
        cityManager.setStation(station, type: cityType)
    }
}
