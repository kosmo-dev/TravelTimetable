//
//  SettingsView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 04.04.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @State private var sheetIsVisible = false
    
    var body: some View {
        mainView
            .background(.ypWhiteDL)
            .sheet(isPresented: $sheetIsVisible) {
                WebView(url: URL(string: "https://yandex.ru/legal/practicum_offer")!)
            }
    }
    
    var mainView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Темная тема")
                    .padding(.vertical, 19)
                    .foregroundStyle(Color.ypBlackDL)
                    .font(.system(size: 17))
                Spacer()
                Toggle("", isOn: $isDarkMode)
                    .tint(Color.ypBlue)
            }
            HStack {
                Text("Пользовательское соглашение")
                    .padding(.vertical, 19)
                    .foregroundStyle(Color.ypBlackDL)
                    .font(.system(size: 17))
                Spacer()
                Image(systemName: "chevron.right")
                    .fontWeight(.bold)
            }
            .onTapGesture {
                sheetIsVisible = true
            }
            Spacer()
            Text("Приложение использует API 'Яндекс.Расписания'")
                .foregroundStyle(Color.ypBlackDL)
                .font(.system(size: 12))
                .padding(.bottom)
            Text("Версия 1.0 (beta)")
                .foregroundStyle(Color.ypBlackDL)
                .font(.system(size: 12))
        }
        .padding(.top, 24)
        .padding(.horizontal)
    }
}

#Preview {
    SettingsView()
}
