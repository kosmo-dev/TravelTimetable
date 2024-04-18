//
//  SplashScreen.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 18.04.2024.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        Image(.splashScreen)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
}

#Preview {
    SplashScreen()
}
