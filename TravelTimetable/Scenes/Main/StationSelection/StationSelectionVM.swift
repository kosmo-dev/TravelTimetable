//
//  StationSelectionVM.swift
//  TravelTimetable
//
//  Created by Vadim on 30.06.2024.
//

import Foundation

final class StationSelectionViewModel: ObservableObject {
    enum State {
        case loaded
        case emptySearch
        case serverError
        case noInternet
    }
    
    @Published var state: State = .loaded
    @Published var searchText = ""
    @Published var visibleList: [Station] = [] {
        didSet {
            checkAndChangeState()
        }
    }
    private var list: [Station] = []
    
    var onDismiss: () -> Void

    private weak var cityManager: CityManagerProtocol?
    private var cityType: CityType

    init(cityManager: CityManagerProtocol, cityType: CityType, onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
        self.cityManager = cityManager
        self.cityType = cityType
    }
    
    func onAppear() {
        list = makeStationList()
        visibleList = list
    }
    
    func performSearch(text: String) {
        searchText = text
        
        guard text != "" else {
            visibleList = list
            return
        }
        visibleList = list.filter({ station in
            guard let title = station.title else { return false }
            return title.lowercased().contains(text.lowercased())
        })
    }

    func checkAndChangeState() {
        if visibleList.isEmpty {
            state = .emptySearch
        } else {
            state = .loaded
        }
    }

    func chooseStaion(_ station: Station) {
        cityManager?.setStation(station, type: cityType)
    }
}

extension StationSelectionViewModel {
    private func makeStationList() -> [Station] {
        switch cityType {
        case .arrival:
            return cityManager?.arrivalCity?.stations ?? []
        case .departure:
            return cityManager?.departureCity?.stations ?? []
        }
    }
}
