//
//  FilterView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 06.04.2024.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        mainView
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

    var mainView: some View {
        VStack(alignment: .leading) {

            title(text: "Время отправления")
                .padding(.vertical)
            timeCheckbox(text: "Утро 06:00 - 12:00", isSelected: .constant(true))
                .padding(.vertical, 19)
            timeCheckbox(text: "День 12:00 - 18:00", isSelected: .constant(false))
                .padding(.vertical, 19)
            timeCheckbox(text: "Вечер 18:00 - 00:00", isSelected: .constant(true))
                .padding(.vertical, 19)
            timeCheckbox(text: "Ночь 00:00 - 06:00", isSelected: .constant(false))
                .padding(.vertical, 19)

            title(text: "Показывать варианты с пересадками")
                .padding(.vertical)
            changeCheckbox(text: "Да", isSelected: .constant(true))
                .padding(.vertical, 19)
            changeCheckbox(text: "Нет", isSelected: .constant(false))
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

        }
    }

    var confirmButton: some View {
        Button(action: {
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
    FilterView()
}
