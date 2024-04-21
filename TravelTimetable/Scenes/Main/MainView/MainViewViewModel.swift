//
//  MainViewViewModel.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 18.04.2024.
//

import SwiftUI

final class MainViewViewModel: ObservableObject {

    @Published var departureStation: String = ""
    @Published var arrivalStation: String = ""
    @Published var cityCelectionIsPresented = false
    @Published var routeIsPresented = false
    @Published var storyIsPresented = false
    @Published var choosedStory: Story?
    @Published var backgroundColor: Color = .ypWhiteDL

    let stories: [Story] = Story.mock

    func showDepartureCities() {

    }

    func showArrivalCities() {

    }

    func showRoute() {

    }

    func swapCities() {
        
    }
}
