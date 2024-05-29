//
//  CityManager.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 30.04.2024.
//

import Foundation
import Combine

protocol CityManagerProtocol {
    var action: PassthroughSubject <CityManagerAction, Never> { get }
    var departureCity: String? { get }
    var departureStation: String? { get }
    var arrivalCity: String? { get }
    var arrivalStation: String? { get }

    func setCity(_ city: String, type: CityType)
    func setStation(_ station: String, type: CityType)
    func swapCities()
}

enum CityManagerAction {
    case citiesNeedUpdate
}

enum CityType {
    case arrival
    case departure
}

final class CityManager: CityManagerProtocol {
    private(set) var action: PassthroughSubject<CityManagerAction, Never> = .init()
    private(set) var departureCity: String?
    private(set) var departureStation: String?
    private(set) var arrivalCity: String?
    private(set) var arrivalStation: String?

    func setCity(_ city: String, type: CityType) {
        switch type {
        case .arrival:
            arrivalCity = city
        case .departure:
            departureCity = city
        }
        action.send(.citiesNeedUpdate)
    }

    func setStation(_ station: String, type: CityType) {
        switch type {
        case .arrival:
            arrivalStation = station
        case .departure:
            departureStation = station
        }
        action.send(.citiesNeedUpdate)
    }

    func swapCities() {
        (departureStation, arrivalStation) = (arrivalStation, departureStation)
        (departureCity, arrivalCity) = (arrivalCity, departureCity)
        action.send(.citiesNeedUpdate)
    }
}
