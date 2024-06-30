//
//  CitySelectionVM.swift
//  TravelTimetable
//
//  Created by Vadim on 30.06.2024.
//

import Foundation

@MainActor
final class CitySelectionViewModel: ObservableObject {
    enum Errors: Error {
        case unableMakeStationSelectionViewModel
    }
    enum State {
        case loading
        case loaded
        case emptySearch
        case serverError
        case noInternet
    }
    
    enum Destination: Hashable {
        case stationSelection
    }

    @Published var state: State = .loading
    @Published var searchText = ""
    @Published var visibleList: [Settlement] {
        didSet {
            checkAndChangeState()
        }
    }
    @Published var path: [Destination] = []

    var onDismiss: () -> Void
    
    private var list: [Settlement] = []

    private weak var cityManager: CityManagerProtocol?
    private weak var networkRequest: RequestProtocol?
    private var cityType: CityType
    private var nearestCity: Settlement?

    init(cityManager: CityManagerProtocol, cityType: CityType, networkRequest: RequestProtocol, onDismiss: @escaping () -> Void) {
        self.cityManager = cityManager
        self.cityType = cityType
        self.networkRequest = networkRequest
        self.onDismiss = onDismiss
        visibleList = list
    }
    
    func fetchAllCitis() async {
        guard let countries = try? await networkRequest?.getListOfAllStations() else { return }
        
        for country in countries {
            
            guard let regions = country.regions else { continue }
            
            for region in regions {
                
                guard let settlements = region.settlements else { continue }
                
                for settlement in settlements {
                    list.append(settlement)
                }
            }
        }
        
        await fetchAndShowNearestCity()
    }

    func performSearch(text: String) {
        searchText = text
        
        guard text != "" else {
            if let nearestCity {
                visibleList = [nearestCity]
            } else {
                visibleList = []
            }
            return
        }
        visibleList = list.filter({ settlement in
            guard let title = settlement.title else { return false }
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
    
    func showStationSelection(selectedCity: Settlement) {
        cityManager?.setCity(selectedCity, type: cityType)
        path.append(.stationSelection)
    }
    
    func makeStationSelectionViewModel() throws -> StationSelectionViewModel {
        guard let cityManager else { throw Errors.unableMakeStationSelectionViewModel }
        return StationSelectionViewModel(cityManager: cityManager, cityType: cityType, onDismiss: onDismiss)
    }
}

extension CitySelectionViewModel {
    private func fetchAndShowNearestCity() async {
        if let nearestCityTitle = await fetchNearestCity() {
            if let matchedCity = list.first(where: { $0.title == nearestCityTitle }) {
                visibleList = [matchedCity]
                nearestCity = matchedCity
            }
        } else {
            visibleList = list
        }
    }
    
    private func fetchNearestCity() async -> String? {
        return try? await networkRequest?.getNearestSettlement(coordinates: nil).popular_title
    }
}
