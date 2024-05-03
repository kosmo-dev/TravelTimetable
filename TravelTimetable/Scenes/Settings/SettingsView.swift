//
//  SettingsView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 04.04.2024.
//

import SwiftUI

struct SettingsView: View {    
    
    private var viewModel: SettingViewModel
    
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        mainView
            .background(.ypWhiteDL)
    }
    
    var mainView: some View {
        let toggleBinding = Binding<Bool>(
            get: { viewModel.colorToogleIsOn },
            set: { viewModel.setColorScheme($0)})
        
        return VStack(spacing: 0) {
            HStack {
                Text("Темная тема")
                    .padding(.vertical, 19)
                    .foregroundStyle(Color.ypBlackDL)
                    .font(.system(size: 17))
                Spacer()
                Toggle("", isOn: toggleBinding)
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
    SettingsView(viewModel: SettingViewModel(colorSchemeManager: ColorSchemeManager()))
}
