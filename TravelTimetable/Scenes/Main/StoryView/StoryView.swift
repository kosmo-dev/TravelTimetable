//
//  StoryView.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 06.04.2024.
//

import SwiftUI

struct StoryView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: StoryViewModel

    var body: some View {
        mainView
            .ignoresSafeArea()
            .onAppear {
                viewModel.onAppear()
            }
            .onDisappear {
                viewModel.onDissappear()
            }
            .onTapGesture {
                withAnimation {
                    viewModel.onStoryTapped()
                }
            }
            .onReceive(viewModel.$storySheetIsVisible, perform: { _ in
                if viewModel.storySheetIsVisible == false {
                    dismiss()
                }
            })
            .onReceive(viewModel.timer, perform: { _ in
                viewModel.onReceiveTimer()
            })
            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                .onEnded { value in
                    withAnimation {
                        viewModel.onEndedDragGesture(translation: value.translation)
                    }
                })
    }

    var mainView: some View {
        ZStack {
            Color.ypBlack
            ZStack {
                VStack {
                    ZStack {
                        ForEach(viewModel.stories.indices) { i in
                            if viewModel.currentStoryIndex == i {
                                Image(viewModel.stories[i].images[viewModel.currentImageIndex])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                                    .transition(.push(from: viewModel.pushEdge).combined(with: .scale(scale: 0.7)))
                            }
                        }
                    }
                    Spacer()
                }

                ProgressBar(numberOfSection: viewModel.currentStory.images.count, progress: viewModel.progress)
                    .padding(.horizontal, 12)
                    .padding(.top, 28)

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

                    Text(viewModel.currentStory.title)
                        .lineLimit(2)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .padding(.bottom, 16)

                    Text(viewModel.currentStory.description)
                        .lineLimit(3)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .padding(.bottom, 80)
                }
            }
        }
    }
}

#Preview {
    Spacer()
        .sheet(isPresented: .constant(true), content: {
            StoryView(viewModel: StoryViewModel(stories: [Story(id: "2", images: ["story2-0", "story2-1"], previewImage: "storyPreview2", title: "Story 2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", isViewed: false)], currentStoryIndex: 2, storiesManager: StoriesManager()))
        })
}
