//
//  RouteListVM.swift
//  TravelTimetable
//
//  Created by Vadim on 30.06.2024.
//

import Foundation
import SwiftUI

final class RouteListViewModel: ObservableObject {
    enum State {
        case loaded
        case empty
        case serverError
        case noInternet
    }
    
    enum FilterButtonState {
        case withFilter
        case none
    }
    
    @Published var state: State = .loaded
    @Published var routeTitle: RouteTitle
    @Published var segments: [Segment] = []
    @Published var filterButtonState: FilterButtonState = .none
    
    private weak var networkRequest: RequestProtocol?
    private weak var cityManager: CityManager?
    
    init(routeTitle: RouteTitle, networkRequest: RequestProtocol, cityManager: CityManager) {
        self.routeTitle = routeTitle
        self.networkRequest = networkRequest
        self.cityManager = cityManager
    }
    
    func makeFilterView() -> FilterView {
        let filterViewModel = FilterViewModel { [weak self] in
            self?.filterButtonState = .withFilter
        }
        return FilterView(viewModel: filterViewModel)
    }
    
    func searchRoutes() async {
        guard let depStationCode = cityManager?.departureStation?.codes?.yandex_code,
              let arrStationCode = cityManager?.arrivalStation?.codes?.yandex_code
        else { return }
        let route = try? await networkRequest?.searchRoutes(from: depStationCode, to: arrStationCode)
        if let segments = route?.segments {
            self.segments = segments
        }
    }
}

struct RoutesMock {
    static let mock: [Route] = [
        Route(
            arrival_date: "14 января",
            uid: UUID().uuidString,
            interval: Components.Schemas.Interval(
                density: "20 часов",
                end_time: "08:15",
                begin_time: "22:30"),
            carrier: Components.Schemas.Carrier(
                logo_svg: "MockCarrierIcon",
                title: "РЖД",
                phone: "+7 (495) 123-45-67",
                email: "mockemail@email.ru"
            ),
            stops: [
                Components.Schemas.Stop(
                    station: Components.Schemas.Station(title: "Кострома")
                )
            ]
        ),
        Route(
            arrival_date: "15 января",
            uid: UUID().uuidString,
            interval: Components.Schemas.Interval(
                density: "9 часов",
                end_time: "01:15",
                begin_time: "09:00"),
            carrier: Components.Schemas.Carrier(
                logo_svg: "MockCarrierIcon",
                title: "ФГК",
                phone: "+7 (495) 123-45-67",
                email: "mockemail@email.ru"
            ),
            stops: []
        ),
        Route(
            arrival_date: "16 января",
            uid: UUID().uuidString,
            interval: Components.Schemas.Interval(
                density: "9 часов",
                end_time: "12:30",
                begin_time: "21:00"),
            carrier: Components.Schemas.Carrier(
                logo_svg: "MockCarrierIcon",
                title: "Урал Логистика",
                phone: "+7 (495) 123-45-67",
                email: "mockemail@email.ru"
            ),
            stops: []
        ),
        Route(
            arrival_date: "17 января",
            uid: UUID().uuidString,
            interval: Components.Schemas.Interval(
                density: "20 часов",
                end_time: "08:15",
                begin_time: "22:30"),
            carrier: Components.Schemas.Carrier(
                logo_svg: "MockCarrierIcon",
                title: "РЖД",
                phone: "+7 (495) 123-45-67",
                email: "mockemail@email.ru"
            ),
            stops: [
                Components.Schemas.Stop(
                    station: Components.Schemas.Station(title: "Кострома")
                )
            ]
        ),
        Route(
            arrival_date: "18 января",
            uid: UUID().uuidString,
            interval: Components.Schemas.Interval(
                density: "12 часов",
                end_time: "08:15",
                begin_time: "20:30"),
            carrier: Components.Schemas.Carrier(
                logo_svg: "MockCarrierIcon",
                title: "РЖД",
                phone: "+7 (495) 123-45-67",
                email: "mockemail@email.ru"
            ),
            stops: []
        ),
        Route(
            arrival_date: "18 января",
            uid: UUID().uuidString,
            interval: Components.Schemas.Interval(
                density: "4 часов",
                end_time: "08:15",
                begin_time: "12:30"),
            carrier: Components.Schemas.Carrier(
                logo_svg: "MockCarrierIcon",
                title: "РЖД Сапсан",
                phone: "+7 (495) 123-45-67",
                email: "mockemail@email.ru"
            ),
            stops: []
        )
    ]
}
