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
    
    @ViewBuilder
    var mainView: some View {
        switch viewModel.state {
        case .loaded:
            loadedView
        case .empty:
            emptyView
        case .serverError:
            ServerErrorView()
        case .noInternet:
            NoInternetView()
        }
    }
    
    var loadedView: some View {
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
    
    var emptyView: some View {
        VStack {
            routeTitle
                .padding(.horizontal)
            Spacer()
            Text("Вариантов нет")
                .foregroundStyle(.ypBlackDL)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }
    
    @ViewBuilder
    var routeTitle: some View {
        if let depCity = viewModel.routeTitle.departureCity.title,
              let depStation = viewModel.routeTitle.departureStation.title,
              let arrCity = viewModel.routeTitle.arrivalCity.title,
              let arrStation = viewModel.routeTitle.arrivalStation.title
        {
            Text("\(depCity) (\(depStation)) ")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.ypBlackDL)
            + Text(Image(systemName: "arrow.right"))
            + Text(" \(arrCity) (\(arrStation))")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.ypBlackDL)
        }
    }
    
    var list: some View {
        ScrollView(showsIndicators: false) {
            ForEach(viewModel.routes, id: \.uid) { route in
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
            viewModel.makeFilterView()
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
                    if viewModel.filterButtonState == .withFilter {
                        Circle()
                            .frame(width: 8)
                            .foregroundStyle(.ypRed)
                    }
                    Spacer()
                }
            }
        }
        .frame(height: 60)
    }
}

#Preview {
    RouteListView(viewModel: RouteListViewModel(routeTitle: RouteTitle(departureCity: Settlement(title: "Moscow"), departureStation: Station(title: "station"), arrivalCity: Settlement(title: "Saint Petersburg"), arrivalStation: Station(title: "station")), routes: RoutesMock.mock))
}
