//
//  Request.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 08.03.2024.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

protocol RequestProtocol {
    func getNearestStations()
    func searchRoutes()
    func getScheduleForStation()
    func getNearestSettlement()
    func getRoute()
    func getCarrierInfo()
    func getListOfAllStations()
    func getCopyright()
}

final class Request: RequestProtocol {
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

    func getNearestStations() {
        Task {
            do {
                let nearestStations = try await network.getNearestStations(lat: 55.734300, lng: 37.588230, distance: 20)
                print(nearestStations)
            } catch {
                print(error)
            }
        }
    }

    func searchRoutes() {
        Task {
            do {
                let searchRoutes = try await network.searchRoutes(from: "c213", to: "c2", date: "2024-03-23")
                print(searchRoutes)
            } catch {
                print(error)
            }
        }
    }

    func getScheduleForStation() {
        Task {
            do {
                let schedule = try await network.getScheduleFor(station: "s2000006", date: "2024-03-23")
                print(schedule)
            } catch {
                print(error)
            }
        }
    }

    func getNearestSettlement() {
        Task {
            do {
                let nearestSettlement = try await network.getNearestSettlement(lat: 55.734300, lng: 37.588230)
                print(nearestSettlement)
            } catch {
                print(error)
            }
        }
    }

    func getRoute() {
        Task {
            do {
                let route = try await network.getRoute(from: "c213", to: "c2", date: "2024-03-23")
                print(route)
            } catch {
                print(error)
            }
        }
    }

    func getCarrierInfo() {
        Task {
            do {
                let carrierInfo = try await network.getCarrierInfo(carrierCode: "1", system: .yandex)
                print(carrierInfo)
            } catch {
                print(error)
            }
        }
    }

    func getListOfAllStations() {
        Task {
            do {
                let listOfAllStations = try await network.getListOfAllStations()
                print(listOfAllStations)
            } catch {
                print(error)
            }
        }
    }

    func getCopyright() {
        Task {
            do {
                let copyright = try await network.getCopyright()
                print(copyright)
            } catch {
                print(error)
            }
        }
    }
}
