//
//  CarrierInfoView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 06.04.2024.
//

import SwiftUI

struct CarrierInfoView: View {
    @Environment(\.dismiss) private var dismiss
    var carrier: Carrier

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
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                Image(carrier.logo_svg ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 104)
                Spacer()
            }

            Text(carrier.title ?? "")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.ypBlackDL)
                .padding(.vertical)

            if let email = carrier.email {
                VStack(alignment: .leading, spacing: 0) {
                    Text("E-mail")
                        .font(.system(size: 17))
                        .foregroundStyle(Color.ypBlackDL)

                    Text(email)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.ypBlue)
                }
                .padding(.vertical, 12)
            }

            if let phone = carrier.phone {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Телефон")
                        .font(.system(size: 17))
                        .foregroundStyle(Color.ypBlackDL)

                    Text(phone)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.ypBlue)
                }
                .padding(.vertical, 12)
            }

            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    let carrier = Components.Schemas.Carrier(
        logo_svg: "MockCarrierIcon",
        title: "РЖД",
        phone: "+7 (495) 123-45-67",
        email: "mockemail@email.ru"
    )
    return CarrierInfoView(carrier: carrier)
}
