//
//  FilterView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 06.04.2024.
//

import SwiftUI

struct FilterView: View {
    
    @ObservedObject var viewModel: FilterViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
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

    @ViewBuilder
    var mainView: some View {
        switch viewModel.viewState {
        case .loaded:
            filterView
        case .serverError:
            ServerErrorView()
        case .noInternet:
            NoInternetView()
        }
        
    }
    
    var filterView: some View {
        let morningBinding = Binding<Bool>(
            get: { viewModel.selectedTime == .morningTime },
            set: { _ in viewModel.timeCheckboxTapped(.morningTime) }
        )
        let afternoonBinding = Binding<Bool>(
            get: { viewModel.selectedTime == .afernoonTime },
            set: {  _ in viewModel.timeCheckboxTapped(.afernoonTime) }
        )
        let eveningBinding = Binding<Bool>(
            get: { viewModel.selectedTime == .eveningTime },
            set: {  _ in viewModel.timeCheckboxTapped(.eveningTime) }
        )
        let nightBinding = Binding<Bool>(
            get: { viewModel.selectedTime == .nightTime },
            set: {  _ in viewModel.timeCheckboxTapped(.nightTime) }
        )
        
        let transferCheckBoxYes = Binding<Bool>(
            get: { viewModel.selectedTransfer == .showTransfer },
            set: {  _ in viewModel.transferCheckboxTapped(.showTransfer) }
        )
        let transferCheckBoxNo = Binding<Bool>(
            get: { viewModel.selectedTransfer == .hideTransfer },
            set: {  _ in viewModel.transferCheckboxTapped(.hideTransfer) }
        )
        
        return VStack(alignment: .leading) {

            title(text: "Время отправления")
                .padding(.vertical)
            timeCheckbox(text: "Утро 06:00 - 12:00", isSelected: morningBinding)
                .padding(.vertical, 19)
            timeCheckbox(text: "День 12:00 - 18:00", isSelected: afternoonBinding)
                .padding(.vertical, 19)
            timeCheckbox(text: "Вечер 18:00 - 00:00", isSelected: eveningBinding)
                .padding(.vertical, 19)
            timeCheckbox(text: "Ночь 00:00 - 06:00", isSelected: nightBinding)
                .padding(.vertical, 19)

            title(text: "Показывать варианты с пересадками")
                .padding(.vertical)
            changeCheckbox(text: "Да", isSelected: transferCheckBoxYes)
                .padding(.vertical, 19)
            changeCheckbox(text: "Нет", isSelected: transferCheckBoxNo)
                .padding(.vertical, 19)

            Spacer()

            confirmButton
        }
        .padding(.horizontal)
    }

    func title(text: String) -> some View {
        Text(text)
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(Color.ypBlackDL)
    }

    func timeCheckbox(text: String, isSelected: Binding<Bool>) -> some View {
        HStack {

            Text(text)
                .font(.system(size: 17))
                .foregroundStyle(Color.ypBlackDL)

            Spacer()

            Image(systemName: "checkmark")
                .opacity(isSelected.wrappedValue ? 1 : 0)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.ypWhiteDL)
                .padding(4)
                .overlay {
                    RoundedRectangle(cornerRadius: 2)
                        .opacity(isSelected.wrappedValue ? 0 : 1)
                        .foregroundStyle(Color.ypWhiteDL)
                        .padding(2)
                }
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(Color.ypBlackDL)
                }
                .onTapGesture {
                    isSelected.wrappedValue.toggle()
                }
        }
    }

    func changeCheckbox(text: String, isSelected: Binding<Bool>) -> some View {
        HStack {
            Text(text)
                .font(.system(size: 17))
                .foregroundStyle(Color.ypBlackDL)

            Spacer()

            ZStack {
                Circle()
                    .foregroundStyle(Color.ypBlackDL)
                    .frame(width: 20)
                Circle()
                    .foregroundStyle(Color.ypWhiteDL)
                    .frame(width: 16)
                Circle()
                    .opacity(isSelected.wrappedValue ? 1 : 0)
                    .foregroundStyle(Color.ypBlackDL)
                    .frame(width: 10)
            }
            .onTapGesture {
                isSelected.wrappedValue.toggle()
            }
        }
    }

    var confirmButton: some View {
        Button(action: {
            viewModel.confirmButtonTapped()
            dismiss()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color.ypBlue)
                HStack {
                    Spacer()
                    Text("Применить")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 20)
                    Spacer()
                }
            }
        })
        .frame(height: 60)
    }
}

#Preview {
    FilterView(viewModel: FilterViewModel(onConfirmButtonTapped: {}))
}
