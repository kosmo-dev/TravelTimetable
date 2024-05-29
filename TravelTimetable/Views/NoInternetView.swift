//
//  NoInternetView.swift
//  TravelTimetable
//
//  Created by Vadim on 29.05.2024.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(.noInternet)
                .resizable()
                .frame(width: 223, height: 223)
                .scaledToFit()
            
            Text("Нет интернета")
                .foregroundStyle(.ypBlackDL)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }
}

#Preview {
    NoInternetView()
}
