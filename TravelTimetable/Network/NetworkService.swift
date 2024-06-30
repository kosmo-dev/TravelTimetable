//
//  Test.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 06.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias NearestStations = Components.Schemas.StationsResponse
typealias SettlementResponse = Components.Schemas.NearestSettlementResponse
typealias SearchRoutes = Components.Schemas.SearchResponse
typealias Schedule = Components.Schemas.ScheduleResponse
typealias Route = Components.Schemas.ThreadResponse
typealias CarrierInfo = Components.Schemas.CarrierResponse
typealias CountriesList = Components.Schemas.StationsList
typealias Copyright = Components.Schemas.CopyrightInfo
typealias CarrierSystem = Operations.getCarrierInformation.Input.Query.systemPayload
typealias Settlement = Components.Schemas.Settlement
typealias Country = Components.Schemas.Country
typealias Station = Components.Schemas.Stations

typealias Carrier = Components.Schemas.Carrier

protocol NetworkServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    func getNearestSettlement(lat: Double, lng: Double) async throws -> SettlementResponse
    func searchRoutes(from: String, to: String, date: String?) async throws -> SearchRoutes
    func getScheduleFor(station: String, date: String?) async throws -> Schedule
    func getRoute(from: String, to: String, date: String?) async throws -> Route
    func getCarrierInfo(carrierCode: String, system: CarrierSystem) async throws -> CarrierInfo
    func getListOfAllStations() async throws -> [Country]?
    func getCopyright() async throws -> Copyright
}

actor NetworkService: NetworkServiceProtocol {
    private let client: Client
    private let apikey: String
    
    private var listOFAllCitiesCache: [Components.Schemas.Country] = []

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }

    func getNearestSettlement(lat: Double, lng: Double) async throws -> SettlementResponse {
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng
        ))
        return try response.ok.body.json
    }

    func searchRoutes(from: String, to: String, date: String?) async throws -> SearchRoutes {
        let response = try await client.searchRoutes(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date
        ))
        return try response.ok.body.json
    }

    func getScheduleFor(station: String, date: String?) async throws -> Schedule {
        let response = try await client.getScheduleForStation(query: .init(
            apikey: apikey,
            station: station,
            date: date
        ))
        return try response.ok.body.json
    }

    func getRoute(from: String, to: String, date: String?) async throws -> Route {
        let route = try await searchRoutes(from: from, to: to, date: date)
        guard let routeId = route.segments?.first?.thread?.uid else { throw NetworkServiceError.noThreadId}
        let response = try await client.getThreadDetails(query: .init(
            apikey: apikey,
            uid: routeId
        ))
        return try response.ok.body.json
    }

    func getCarrierInfo(carrierCode: String, system: CarrierSystem) async throws -> CarrierInfo {
        let response = try await client.getCarrierInformation(query: .init(
            apikey: apikey,
            code: "150"
        ))
        return try response.ok.body.json
    }

    func getListOfAllStations() async throws -> [Country]? {
        guard listOFAllCitiesCache.isEmpty else { return listOFAllCitiesCache }
        
        let response = try await client.getStationsList(query: .init(apikey: apikey))
        let httpBody = try response.ok.body.html
        let stationList = try await httpBody.decode(to: CountriesList.self)
        
        listOFAllCitiesCache = stationList.countries ?? []
        return stationList.countries
    }

    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyrightInformation(query: .init(
            apikey: apikey,
            format: .json
        ))
        return try response.ok.body.json
    }
}

extension NetworkService {
    enum NetworkServiceError: Error {
        case noThreadId
        case unsupportedHTTPBody
    }
}
