//
//  ServerErrorView.swift
//  TravelTimetable
//
//  Created by Vadim on 29.05.2024.
//

import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(.serverError)
                .resizable()
                .frame(width: 223, height: 223)
                .scaledToFit()
            
            Text("Ошибка сервера")
                .foregroundStyle(.ypBlackDL)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }
}

#Preview {
    ServerErrorView()
}
