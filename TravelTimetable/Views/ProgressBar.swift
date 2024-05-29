//
//  ProgressBar.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 29.05.2024.
//

import SwiftUI

struct ProgressBar: View {
    let numberOfSection: Int
    let progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: geometry.size.width, height: 6)
                    .foregroundColor(.white)

                RoundedRectangle(cornerRadius: 6)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: 6
                    )
                    .foregroundStyle(.blue)
            }
            .mask {
                MaskView(numberOfSections: numberOfSection)
            }
        }
    }
}

struct MaskView: View {
    let numberOfSections: Int

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(Color.white)
            .frame(height: 6)
    }
}
