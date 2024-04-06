//
//  CitySelectionView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 05.04.2024.
//

import SwiftUI

struct CitySelectionView: View {
    @Binding var modalViewIsPresented: Bool
    @Environment(\.dismiss) private var dismiss
    @State var searchText = ""

    let list: [String] = ["Москва", "Санкт-Петербург", "Сочи", "Горный Воздух", "Краснодар", "Казань", "Омск"]

    var body: some View {
        NavigationView {
            mainView
                .background(.ypWhiteDL)
                .navigationTitle("Выбор города")
                .navigationBarTitleDisplayMode(.inline)
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
                .searchable(text: $searchText, prompt: "Введите запрос")
        }
    }

    var mainView: some View {
        ScrollView {
            ForEach(list, id: \.self) { item in
                NavigationLink {
                    StationSelection(modalViewIsPresented: $modalViewIsPresented, city: item)
                } label: {
                    listRow(city: item)
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
}

#Preview {
    CitySelectionView(modalViewIsPresented: .constant(true))
}
