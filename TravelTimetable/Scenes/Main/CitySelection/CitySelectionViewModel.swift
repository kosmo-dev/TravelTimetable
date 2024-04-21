//
//  CitySelectionViewModel.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 21.04.2024.
//

import Foundation

final class CitySelectionViewModel: ObservableObject {
    enum State {
        case loaded
        case emptySearch
    }

    @Published var state: State = .loaded
    @Published var searchText = ""
    @Published var visibleList: [String]
    private var list: [String] = ["Москва", "Санкт-Петербург", "Сочи", "Горный Воздух", "Краснодар", "Казань", "Омск"]

    var onDismiss: () -> Void

    init(onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
        visibleList = list
    }

    func performSearch(text: String) {
        searchText = text
        
        guard text != "" else {
            visibleList = list
            return
        }

        visibleList = list.filter { $0.lowercased().contains(text.lowercased()) }
        checkAndChangeState()
    }

    func checkAndChangeState() {
        if visibleList.isEmpty {
            state = .emptySearch
        } else {
            state = .loaded
        }
    }

}
