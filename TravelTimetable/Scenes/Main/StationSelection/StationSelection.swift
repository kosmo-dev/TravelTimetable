//
//  StationSelection.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 05.04.2024.
//

import SwiftUI

struct StationSelection: View {
    @Binding var modalViewIsPresented: Bool
    @Environment(\.dismiss) private var dismiss
    @State var searchText = ""

    let list: [String] = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    let city: String

    var body: some View {
        mainView
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
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Введите запрос")
    }
    
    var mainView: some View {
        ScrollView {
            ForEach(list, id: \.self) { item in
                listRow(city: item)
                    .onTapGesture {
                        modalViewIsPresented = false
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
    StationSelection(modalViewIsPresented: .constant(true), city: "Москва")
}
