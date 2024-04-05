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
        VStack {
            Text("Время отправления")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.ypBlackDL)

            HStack {
                
            }
        }
    }
}

#Preview {
    FilterView()
}
