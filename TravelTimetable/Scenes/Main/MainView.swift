//
//  MainView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 04.04.2024.
//

import SwiftUI

struct MainView: View {
    let stories: [Story] = [
        Story(id: "1", image: "1", text: "Story 1"),
        Story(id: "2", image: "2", text: "Story 2"),
        Story(id: "3", image: "3", text: "Story 3"),
        Story(id: "4", image: "4", text: "Story 4"),
    ]

    @State var fromSearch: String = ""
    @State var toSearch: String = ""

    var body: some View {
        NavigationView {
            mainView
        }
    }

    var mainView: some View {
        VStack {
            storiesView
            searchView
            Spacer()
        }
    }

    var storiesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                Spacer(minLength: 16)
                ForEach(stories) { story in
                    storyView(story: story)
                }
            }
        }
    }

    func storyView(story: Story) -> some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.yellow)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.ypBlue, lineWidth: 4)
            }
            .frame(width: 92, height: 140)
    }

    var searchView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color.ypBlue)
            HStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.white)
                    VStack( spacing: 28) {
                        HStack {
                            Text("Откуда")
                                .foregroundStyle(Color.ypGray)
                            Spacer()
                        }
                        HStack {
                            Text("Куда")
                                .foregroundStyle(Color.ypGray)
                            Spacer()
                        }
                    }
                    .padding()
                }
                .padding()
                Circle()
                    .foregroundStyle(Color.white)
                    .frame(width: 36)
                    .overlay {
                        Image(systemName: "arrow.left.arrow.right")
                            .foregroundStyle(Color.ypBlue)
                    }
                    .padding(.trailing)
            }
        }
        .padding()
        .frame(height: 128)
    }
}

#Preview {
    MainView()
}
