//
//  MainView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 04.04.2024.
//

import SwiftUI

struct MainView: View {

    @ObservedObject var viewModel: MainViewViewModel

    var body: some View {
        NavigationView {
            mainView
                .background(viewModel.backgroundColor)
                .fullScreenCover(isPresented: $viewModel.cityCelectionIsPresented, content: {
                    CitySelectionView(viewModel: CitySelectionViewModel(onDismiss: {
                        viewModel.cityCelectionIsPresented = false
                    }))
                })
                .fullScreenCover(isPresented: $viewModel.routeIsPresented, content: {
                    RouteListView()
                })
                .sheet(isPresented: $viewModel.storyIsPresented, onDismiss: {
                    withAnimation {
                        viewModel.backgroundColor = .ypWhiteDL
                    }
                }, content: {
                    if let story = viewModel.choosedStory {
                        StoryView(story: story)
                    }
                })
        }
    }

    var mainView: some View {
        VStack(spacing: 0) {
            storiesView
            searchView
                .padding(.top, 20)
                .padding(.horizontal, 16)
            searchButton
                .padding()
            Spacer()
        }
    }

    var storiesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                Spacer(minLength: 16)
                ForEach(viewModel.stories) { story in
                    storyView(story: story)
                        .onTapGesture {
                            viewModel.choosedStory = story
                            viewModel.storyIsPresented = true
                            withAnimation {
                                viewModel.backgroundColor = .black
                            }
                        }
                }
            }
        }
        .frame(height: 188)
    }

    func storyView(story: Story) -> some View {
        Image(story.previewImage)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                ZStack(alignment: .bottom) {
                    HStack {
                        Text(story.title)
                            .font(.system(size: 12))
                            .lineLimit(3)
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 12)
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.ypBlue, lineWidth: 4)
                }
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
                        .background(.white)
                        .onTapGesture {
                            viewModel.cityCelectionIsPresented = true
                        }
                        HStack {
                            Text("Куда")
                                .foregroundStyle(Color.ypGray)
                            Spacer()
                        }
                        .background(.white)
                        .onTapGesture {
                            viewModel.cityCelectionIsPresented = true
                        }
                    }
                    .padding()
                }
                .padding()
                changeDirectionButton
            }
        }
        .frame(height: 128)
    }

    var changeDirectionButton: some View {
        Image("icСhange")
            .padding(.trailing)
    }

    var searchButton: some View {
        Button(action: {
            viewModel.routeIsPresented = true
        }, label: {
            Text("Найти")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.white)
                .padding(.vertical, 20)
                .padding(.horizontal, 47.5)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color.ypBlue)
                )
        })
    }
}

#Preview {
    MainView(viewModel: MainViewViewModel())
}
