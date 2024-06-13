//
//  StoryViewModel.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 29.05.2024.
//

import SwiftUI
import Combine

final class StoryViewModel: ObservableObject {
    
    @Published var progress: CGFloat = 0
    @Published var storySheetIsVisible: Bool = true
    @Published var pushEdge: Edge = .trailing
    let stories: [Story]
    var timer: Timer.TimerPublisher = Timer.publish(every: 0.03, on: .main, in: .common)
    
    var currentStory: Story {
        stories[currentStoryIndex]
    }
    var currentImageIndex: Int {
        Int(progress * CGFloat(currentStory.images.count))
    }
    var currentStoryIndex: Int
    
    private var cancellable: Cancellable?
    private let configuration: TimerConfiguration
    private weak var storiesManager: StoriesManagerProtocol?
    
    init(stories: [Story], currentStoryIndex: Int, storiesManager: StoriesManagerProtocol) {
        self.stories = stories
        self.currentStoryIndex = currentStoryIndex
        self.storiesManager = storiesManager
        self.configuration = TimerConfiguration(storiesCount: stories[currentStoryIndex].images.count)
    }
    
    func onAppear() {
        cancellable = timer.connect()
        storiesManager?.markStoryAsRead(currentStory)
    }
    
    func onDissappear() {
        cancellable?.cancel()
    }
    
    func onStoryTapped() {
        nextImageOrStory()
        resetTimer()
    }
    
    func onReceiveTimer() {
        timerTick()
    }
    
    func swipeRight() {
        resetTimer()
        previousStory()
    }
    
    func swipeLeft() {
        resetTimer()
        nextStory()
    }
    
    func onEndedDragGesture(translation: CGSize) {
        let horizontalAmount = translation.width
        let verticalAmount = translation.height
        
        if abs(horizontalAmount) > abs(verticalAmount) {
            pushEdge = horizontalAmount < 0 ? .trailing : .leading
            horizontalAmount < 0 ? swipeLeft() : swipeRight()
        }
    }
}

extension StoryViewModel {
    private func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
    
    private func timerTick() {
        let nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            withAnimation {
                nextImageOrStory()
            }
        } else {
            progress = nextProgress
        }
    }
    
    private func nextImageOrStory() {
        pushEdge = .trailing
        if currentImageIndex >= currentStory.images.count - 1 {
            nextStory()
        } else {
            progress = (CGFloat(currentImageIndex) + 1) / CGFloat(currentStory.images.count)
        }
    }
    
    private func nextStory() {
        progress = 0
        if currentStoryIndex >= stories.count - 1 {
            storySheetIsVisible = false
        } else {
            currentStoryIndex += 1
            storiesManager?.markStoryAsRead(currentStory)
        }
    }
    
    private func previousStory() {
        if currentStoryIndex > 0 {
            currentStoryIndex -= 1
            storiesManager?.markStoryAsRead(currentStory)
            progress = 0
        } else {
            progress = 0
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
}

struct TimerConfiguration {
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat
    
    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 3,
        timerTickInternal: TimeInterval = 0.03
    ) {
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
    }
}

