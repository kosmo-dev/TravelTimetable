//
//  MainViewViewModel.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 18.04.2024.
//

import SwiftUI
import Combine

final class MainViewViewModel: ObservableObject {
    enum Errors: Error {
        case unableMakeCitySelectionView
        case unableMakeRouteListView
    }
    
    enum State {
        case loaded
        case serverError
        case noInternet
    }

    @Published var departureStation: String = ""
    @Published var arrivalStation: String = ""
    @Published var cityCelectionIsPresented = false
    @Published var routeIsPresented = false
    @Published var storyIsPresented = false
    @Published var choosedStory: Story?
    @Published var backgroundColor: Color = .ypWhiteDL
    @Published var viewState: State = .loaded

    private var cityManager: CityManagerProtocol
    private var cityType: CityType?
    private var cancellables: [AnyCancellable] = []

    init(cityManager: CityManagerProtocol) {
        self.cityManager = cityManager
        cityManager.action.sink { [weak self] action in
            switch action {
            case .citiesNeedUpdate:
                self?.getSelectedCities()
            }
        }.store(in: &cancellables)
    }

    let stories: [Story] = Story.mock

    func showDepartureCities() {

    }

    func showArrivalCities() {

    }

    func showRoute() {

    }

    func swapCities() {
        cityManager.swapCities()
    }

    func selectDeparture() {
        cityType = .departure
        cityCelectionIsPresented = true
    }

    func selectArrival() {
        cityType = .arrival
        cityCelectionIsPresented = true
    }

    func makeCitySelectionView() throws -> CitySelectionView {
        guard let cityType else { throw Errors.unableMakeCitySelectionView }
        return CitySelectionView(viewModel: CitySelectionViewModel(cityManager: cityManager, cityType: cityType, onDismiss: { [weak self] in
            self?.cityCelectionIsPresented = false
        }))
    }
    
    func makeRouteListView() throws -> RouteListView {
        guard let arrivalCity = cityManager.arrivalCity,
              let arrivalStation = cityManager.arrivalStation,
              let departureCity = cityManager.departureCity,
              let departureStation = cityManager.departureStation
        else { throw Errors.unableMakeRouteListView }
        return RouteListView(viewModel: RouteListViewModel(routeTitle: RouteTitle(departureCity: departureCity, departureStation: departureStation, arrivalCity: arrivalCity, arrivalStation: arrivalStation), routes: RoutesMock.mock))
    }
}

private extension MainViewViewModel {
    func getSelectedCities() {
        if let depCity = cityManager.departureCity, let depStation = cityManager.departureStation {
            departureStation = "\(depCity) (\(depStation)"
        } else {
            departureStation = ""
        }

        if let arrCity = cityManager.arrivalCity, let arrStation = cityManager.arrivalStation {
            arrivalStation = "\(arrCity) (\(arrStation)"
        } else {
            arrivalStation = ""
        }
    }
}
