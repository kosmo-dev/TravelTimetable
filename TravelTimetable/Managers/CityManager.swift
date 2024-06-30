//
//  CityManager.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 30.04.2024.
//

import Foundation
import Combine

protocol CityManagerProtocol: AnyObject {
    var action: PassthroughSubject <CityManagerAction, Never> { get }
    var departureCity: Settlement? { get }
    var departureStation: Station? { get }
    var arrivalCity: Settlement? { get }
    var arrivalStation: Station? { get }

    func setCity(_ city: Settlement, type: CityType)
    func setStation(_ station: Station, type: CityType)
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
    private(set) var departureCity: Settlement?
    private(set) var departureStation: Station?
    private(set) var arrivalCity: Settlement?
    private(set) var arrivalStation: Station?

    func setCity(_ city: Settlement, type: CityType) {
        switch type {
        case .arrival:
            arrivalCity = city
        case .departure:
            departureCity = city
        }
        action.send(.citiesNeedUpdate)
    }

    func setStation(_ station: Station, type: CityType) {
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
