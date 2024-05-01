//
//  StationSelection.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 05.04.2024.
//

import SwiftUI

struct StationSelection: View {
    
    @ObservedObject var viewModel: StationSelectionViewModel

    var body: some View {
        mainView
            .background(.ypWhiteDL)
            .navigationTitle("Выбор станции")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
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
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Введите запрос")
    }
    
    var mainView: some View {
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
}

#Preview {
    StationSelection(viewModel: StationSelectionViewModel(cityManager: CityManager(), cityType: .arrival, onDismiss: {}))
}
