//
//  StoryView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 06.04.2024.
//

import SwiftUI

struct StoryView: View {
    @Environment(\.dismiss) private var dismiss

    let story: Story

    var body: some View {
        mainView
            .ignoresSafeArea()

    }

    var mainView: some View {
        ZStack {
            Color.ypBlack
            VStack {
                Image(story.images[0])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                Spacer()
            }

            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                            Image("icClose")
                            .resizable()
                            .frame(width: 30, height: 30)
                    })
                }
                .padding(.top, 50)
                .padding(.trailing, 12)
                Spacer()
                Text(story.title)
                    .lineLimit(2)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                Text(story.description)
                    .lineLimit(3)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.bottom, 80)
            }
        }
    }
}

#Preview {
    Spacer()
        .sheet(isPresented: .constant(true), content: {
            StoryView(story: Story(id: "2", images: ["story2-0", "story2-1"], previewImage: "storyPreview2", title: "Story 2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."))
        })
}
