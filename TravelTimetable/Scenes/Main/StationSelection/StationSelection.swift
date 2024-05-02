//
//  StationSelection.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 05.04.2024.
//

import SwiftUI

struct StationSelection: View {
    
    @ObservedObject var viewModel: StationSelectionViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        let searchBinding = Binding<String>(
            get: { viewModel.searchText },
            set: { viewModel.performSearch(text: $0) }
        )
        return mainView
            .background(.ypWhiteDL)
            .navigationTitle("Выбор станции")
            .navigationBarTitleDisplayMode(.inline)
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
            .searchable(text: searchBinding, placement: .navigationBarDrawer(displayMode: .always), prompt: "Введите запрос")
    }
    
    @ViewBuilder
    var mainView: some View {
        switch viewModel.state {
        case .loaded:
            stationsList
        case .emptySearch:
            emptySearch
        }
        
    }
    
    var stationsList: some View {
        ScrollView {
            ForEach(viewModel.visibleList, id: \.self) { item in
                listRow(station: item)
                    .onTapGesture {
                        viewModel.chooseStaion(item)
                        viewModel.onDismiss()
                    }
            }
        }
        .padding(.horizontal)
    }
    
    func listRow(station: String) -> some View {
        HStack {
            Text(station)
                .font(.system(size: 17))
                .foregroundStyle(Color.ypBlackDL)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.ypBlackDL)
        }
        .background(.ypWhiteDL)
        .padding(.vertical, 19)
    }
    
    var emptySearch: some View {
        VStack {
            Spacer()
            Text("Станция не найдена")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.ypBlackDL)
            Spacer()
            
        }
    }
}

#Preview {
    StationSelection(viewModel: StationSelectionViewModel(cityManager: CityManager(), cityType: .arrival, onDismiss: {}))
}
