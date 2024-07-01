//
//  Request.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 08.03.2024.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

protocol RequestProtocol: AnyObject {
    func getNearestStations(coordinates: (lat: Double, lng: Double)?) async throws
    func searchRoutes(from: String, to: String) async throws -> SearchRoutes
    func getScheduleForStation() async throws
    func getNearestSettlement(coordinates: (lat: Double, lng: Double)?) async throws -> SettlementResponse
    func getRoute() async throws -> Route
    func getCarrierInfo() async throws
    func getListOfAllStations() async throws -> [Country]?
    func getCopyright() async throws
}

actor NetworkRequest: RequestProtocol {
    let client: Client
    let network: NetworkServiceProtocol
    
    init() {
        client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        network = NetworkService(
            client: client,
            apikey: "a7201680-2365-4cf4-8d97-0d09cdc2a54c"
        )
    }
    
    func getNearestStations(coordinates: (lat: Double, lng: Double)?) async throws {
        let userCoordinates: (lat: Double, lng: Double) = coordinates ?? (lat: 55.734300, lng: 37.588230)
        let nearestStations = try await network.getNearestStations(lat: userCoordinates.lat, lng: userCoordinates.lng, distance: 20)
    }
    
    func searchRoutes(from: String, to: String) async throws -> SearchRoutes {
        try await network.searchRoutes(from: from, to: to, date: "2024-03-23")
    }
    
    func getScheduleForStation() async throws {
        let schedule = try await network.getScheduleFor(station: "s2000006", date: "2024-03-23")
    }
    
    func getNearestSettlement(coordinates: (lat: Double, lng: Double)?) async throws -> SettlementResponse {
        let userCoordinates: (lat: Double, lng: Double) = coordinates ?? (lat: 55.734300, lng: 37.588230)
        return try await network.getNearestSettlement(lat: userCoordinates.lat, lng: userCoordinates.lng)
    }
    
    func getRoute() async throws -> Route {
        try await network.getRoute(from: "c213", to: "c2", date: "2024-03-23")
    }
    
    func getCarrierInfo() async throws {
        let carrierInfo = try await network.getCarrierInfo(carrierCode: "1", system: .yandex)
    }
    
    func getListOfAllStations() async throws -> [Country]? {
        try await network.getListOfAllStations()
    }
    
    func getCopyright() async throws {
        let copyright = try await network.getCopyright()
    }
}
