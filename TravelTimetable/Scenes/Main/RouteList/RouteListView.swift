//
//  RouteListView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 05.04.2024.
//

import SwiftUI

struct RouteListView: View {
    @ObservedObject var viewModel: RouteListViewModel
    @Environment(\.dismiss) private var dismiss

    var title = "Москва (Ярославский вокзал) - Санкт-Петербург (Московский вокзал)"
    var routes: [Route] = RoutesMock.mock

    var body: some View {
        NavigationView {
            mainView
                .background(.ypWhiteDL)
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color.ypBlackDL)
                        })
                    }
                })
        }
    }

    var mainView: some View {
        ZStack(alignment: .bottom) {
            VStack {
                routeTitle
                    .padding(.horizontal)
                list
                    .padding(.horizontal)
            }
            filterButton
                .padding(.horizontal)
        }
    }

    var routeTitle: some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(Color.ypBlackDL)
    }

    var list: some View {
        ScrollView(showsIndicators: false) {
            ForEach(routes, id: \.uid) { route in
                NavigationLink {
                    if let carrier = route.carrier {
                        CarrierInfoView(carrier: carrier)
                    }
                } label: {
                    listRow(route)
                }
            }
            Spacer(minLength: 100)
        }
    }

    func listRow(_ route: Route) -> some View {
        VStack {

            HStack {

                Image("MockCarrierIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 38, height: 38)

                VStack(alignment: .leading) {

                    HStack(alignment: .top) {

                        Text(route.carrier?.title ?? "")
                            .font(.system(size: 17))
                            .foregroundStyle(Color.ypBlack)

                        Spacer()

                        Text(route.arrival_date ?? "")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.ypBlack)

                    }

                    if let stop = route.stops?.first?.station?.title {
                        Text("С пересадкой в \(stop)")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.ypRed)
                    }

                }
            }

            HStack {

                Text(route.interval?.begin_time ?? "")
                    .font(.system(size: 17))
                    .foregroundStyle(Color.ypBlack)

                Rectangle()
                    .foregroundStyle(Color.ypGray)
                    .frame(height: 1)

                Text(route.interval?.density ?? "")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.ypBlack)

                Rectangle()
                    .foregroundStyle(Color.ypGray)
                    .frame(height: 1)

                Text(route.interval?.end_time ?? "")
                    .font(.system(size: 17))
                    .foregroundStyle(Color.ypBlack)


            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(Color.ypLightGray)
        )
    }

    var filterButton: some View {
        NavigationLink {
            FilterView()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color.ypBlue)

                HStack {
                    Spacer()
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 20)
                    Spacer()
                }
            }
        }
        .frame(height: 60)
    }
}

#Preview {
    RouteListView()
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
