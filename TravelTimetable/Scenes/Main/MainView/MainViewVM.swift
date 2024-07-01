//
//  MainViewVM.swift
//  TravelTimetable
//
//  Created by Vadim on 30.06.2024.
//

import SwiftUI
import Combine

@MainActor
final class MainViewViewModel: ObservableObject {
    enum Errors: Error {
        case unableMakeCitySelectionView
        case unableMakeRouteListView
        case unableMakeStoriesView
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
    
    var stories: [Story] {
        guard let storiesManager else { return [] }
        return storiesManager.stories
    }
    
    private weak var cityManager: CityManagerProtocol?
    private weak var storiesManager: StoriesManagerProtocol?
    private weak var networkRequest: RequestProtocol?
    private var cityType: CityType?
    private var cancellables: [AnyCancellable] = []
    
    init(cityManager: CityManagerProtocol, storiesManager: StoriesManagerProtocol, networkRequest: RequestProtocol) {
        self.cityManager = cityManager
        self.storiesManager = storiesManager
        self.networkRequest = networkRequest
        
        cityManager.action.sink { [weak self] action in
            switch action {
            case .citiesNeedUpdate:
                self?.getSelectedCities()
            }
        }.store(in: &cancellables)
    }
    
    func presentStory(_ story: Story) {
        choosedStory = story
        storyIsPresented = true
    }
    
    func swapCities() {
        cityManager?.swapCities()
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
        guard let cityType,
              let cityManager,
              let networkRequest
        else { throw Errors.unableMakeCitySelectionView }
        return CitySelectionView(viewModel: CitySelectionViewModel(cityManager: cityManager, cityType: cityType, networkRequest: networkRequest, onDismiss: { [weak self] in
            self?.cityCelectionIsPresented = false
        }))
    }
    
    func makeRouteListView() throws -> RouteListView {
        guard let arrivalCity = cityManager?.arrivalCity,
              let arrivalStation = cityManager?.arrivalStation,
              let departureCity = cityManager?.departureCity,
              let departureStation = cityManager?.departureStation
        else { throw Errors.unableMakeRouteListView }
        return RouteListView(viewModel: RouteListViewModel(routeTitle: RouteTitle(departureCity: departureCity, departureStation: departureStation, arrivalCity: arrivalCity, arrivalStation: arrivalStation), routes: RoutesMock.mock))
    }
    
    func makeStoriesView() throws -> StoryView {
        guard let currentStoryIndex = stories.firstIndex(where: { $0.id == choosedStory?.id }),
              let storiesManager
        else {
            throw Errors.unableMakeStoriesView
        }
        
        let viewModel = StoryViewModel(stories: stories, currentStoryIndex: currentStoryIndex, storiesManager: storiesManager)
        return StoryView(viewModel: viewModel)
    }
}

private extension MainViewViewModel {
    func getSelectedCities() {
        if let depCity = cityManager?.departureCity?.title,
           let depStation = cityManager?.departureStation?.title {
            departureStation = "\(depCity) (\(depStation))"
        } else {
            departureStation = ""
        }
        
        if let arrCity = cityManager?.arrivalCity?.title,
           let arrStation = cityManager?.arrivalStation?.title {
            arrivalStation = "\(arrCity) (\(arrStation))"
        } else {
            arrivalStation = ""
        }
    }
}