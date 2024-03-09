//
//  ContentView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 29.02.2024.
//

import SwiftUI

struct ContentView: View {

    let request = Request()

    var body: some View {
        VStack(spacing: 10) {
            Button(action: { request.searchRoutes() }, label: { Text("Routes between stations") })
            Button(action: { request.getScheduleForStation() }, label: { Text("Schedule for station") })
            Button(action: { request.getRoute() }, label: { Text("List of station on route") })
            Button(action: { request.getNearestStations() }, label: { Text("Nearest station") })
            Button(action: { request.getNearestSettlement() }, label: { Text("Nearest settlement") })
            Button(action: { request.getCarrierInfo() }, label: { Text("Carrier info") })
            Button(action: { request.getListOfAllStations() }, label: { Text("List of all stations") })
            Button(action: { request.getCopyright() }, label: { Text("Copyright info") })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
