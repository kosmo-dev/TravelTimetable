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
        switch viewModel.viewState {
        case .loaded:
            NavigationView {
                mainView
                    .background(viewModel.backgroundColor)
                    .fullScreenCover(isPresented: $viewModel.cityCelectionIsPresented, content: {
                        try? viewModel.makeCitySelectionView()
                    })
                    .fullScreenCover(isPresented: $viewModel.routeIsPresented, content: {
                        try? viewModel.makeRouteListView()
                    })
                    .sheet(isPresented: $viewModel.storyIsPresented, onDismiss: {
                        withAnimation {
                            viewModel.backgroundColor = .ypWhiteDL
                        }
                    }, content: {
                        try? viewModel.makeStoriesView()
                    })
            }
        case .serverError:
            ServerErrorView()
        case .noInternet:
            NoInternetView()
        }
    }

    var mainView: some View {
        VStack(spacing: 0) {
            storiesView
            searchView
                .padding(.top, 20)
                .padding(.horizontal, 16)
            if viewModel.departureStation != "" && viewModel.arrivalStation != "" {
                searchButton
                    .padding()
            }
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
                            viewModel.presentStory(story)
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
                        .opacity(story.isViewed ? 0 : 1)
                    RoundedRectangle(cornerRadius: 16)
                        .opacity(story.isViewed ? 0.5 : 0)
                        .foregroundStyle(.white)
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
                            Text(viewModel.departureStation == "" ? "Откуда" : viewModel.departureStation)
                                .foregroundStyle(viewModel.departureStation == "" ? Color.ypGray : Color.ypBlack)
                            Spacer()
                        }
                        .background(.white)
                        .onTapGesture {
                            viewModel.selectDeparture()
                        }
                        HStack {
                            Text(viewModel.arrivalStation == "" ? "Куда" : viewModel.arrivalStation)
                                .foregroundStyle(viewModel.arrivalStation == "" ? Color.ypGray : Color.ypBlack)
                            Spacer()
                        }
                        .background(.white)
                        .onTapGesture {
                            viewModel.selectArrival()
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
        Button {
            viewModel.swapCities()
        } label: {
            Image("icСhange")
                .padding(.trailing)
        }
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
    MainView(viewModel: MainViewViewModel(cityManager: CityManager(), storiesManager: StoriesManager()))
}
