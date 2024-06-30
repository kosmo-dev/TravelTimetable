//
//  CitySelectionView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 05.04.2024.
//

import SwiftUI

struct CitySelectionView: View {

    @ObservedObject var viewModel: CitySelectionViewModel

    var body: some View {
        let searchBinding = Binding<String>(
            get: { viewModel.searchText },
            set: { viewModel.performSearch(text: $0) }
        )

        return NavigationStack(path: $viewModel.path) {
            mainView
                .background(.ypWhiteDL)
                .navigationTitle("Выбор города")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            viewModel.onDismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color.ypBlackDL)
                        })
                    }
                })
                .navigationDestination(for: CitySelectionViewModel.Destination.self, destination: { destination in
                    switch destination {
                    case .stationSelection:
                        try? StationSelection(viewModel: viewModel.makeStationSelectionViewModel())
                    }
                })
                .searchable(text: searchBinding, prompt: "Введите запрос")
                .task {
                    await viewModel.fetchAllCitis()
                }
        }
    }

    @ViewBuilder
    var mainView: some View {
        switch viewModel.state {
        case .loaded:
            citiesList
        case .emptySearch:
            emptySearch
        case .serverError:
            ServerErrorView()
        case .noInternet:
            NoInternetView()
        case .loading:
            ProgressView()
        }
    }

    var citiesList: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.visibleList, id: \.self) { item in
                    if let title = item.title {
                        listRow(city: title)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.showStationSelection(selectedCity: title)
                            }
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    func listRow(city: String) -> some View {
        HStack {
            Text(city)
                .font(.system(size: 17))
                .foregroundStyle(Color.ypBlackDL)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.ypBlackDL)
        }
        .padding(.vertical, 19)
    }

    var emptySearch: some View {
        VStack {
            Spacer()
            HStack {
                
                Spacer()
                Text("Город не найден")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.ypBlackDL)
                Spacer()
                
            }
            Spacer()
        }
    }
}

#Preview {
    CitySelectionView(viewModel: CitySelectionViewModel(cityManager: CityManager(), cityType: .arrival, networkRequest: NetworkRequest(), onDismiss: {}))
}
