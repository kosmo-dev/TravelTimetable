//
//  StationSelectionViewModel.swift
//  TravelTimetable
//
//  Created by Vadim on 23.04.2024.
//

import Foundation

final class StationSelectionViewModel: ObservableObject {
    enum State {
        case loaded
        case emptySearch
    }
    
    let city: String
    
    @Published var state: State = .loaded
    @Published var searchText = ""
    @Published var visibleList: [String]
    private var list: [String] = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    
    var onDismiss: () -> Void

    init(city: String, onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
        visibleList = list
        self.city = city
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
