//
//  FilterViewModel.swift
//  TravelTimetable
//
//  Created by Vadim on 29.05.2024.
//

import SwiftUI

final class FilterViewModel: ObservableObject {
    enum CheckboxTime {
        case morningTime
        case afernoonTime
        case eveningTime
        case nightTime
        case none
    }
    
    enum CheckboxTransfer {
        case showTransfer
        case hideTransfer
    }
    
    enum State {
        case loaded
        case serverError
        case noInternet
    }
    
    @Published var selectedTime: CheckboxTime = .none
    @Published var selectedTransfer: CheckboxTransfer = .showTransfer
    
    @Published var showTransferYes: Bool = true
    @Published var showTransferNo: Bool = false
    
    @Published var viewState: State = .loaded
    
    private var onConfirmButtonTapped: () -> Void
    
    init(onConfirmButtonTapped: @escaping () -> Void) {
        self.onConfirmButtonTapped = onConfirmButtonTapped
    }
    
    
    func confirmButtonTapped() {
        onConfirmButtonTapped()
    }
    
    func timeCheckboxTapped(_ checkbox: CheckboxTime) {
        selectedTime = selectedTime == checkbox ? .none : checkbox
    }
    
    func transferCheckboxTapped(_ checkbox: CheckboxTransfer) {
        selectedTransfer = checkbox
    }
}
