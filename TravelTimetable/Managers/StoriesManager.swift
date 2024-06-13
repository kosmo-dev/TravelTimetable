//
//  StoriesManager.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 29.05.2024.
//

import Foundation
import Combine

protocol StoriesManagerProtocol: AnyObject {
    var action: PassthroughSubject <StoriesManagerAction, Never> { get }
    var stories: [Story] { get }

    func markStoryAsRead(_ story: Story)
}

enum StoriesManagerAction{
    case storiesNeedUpdate
}

final class StoriesManager: StoriesManagerProtocol {
    private(set) var action: PassthroughSubject<StoriesManagerAction, Never> = .init()

    private(set) var stories: [Story] = Mocks.stories

    func markStoryAsRead(_ story: Story) {
        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            let oldStory = stories[index]
            let newStory = Story(
                id: oldStory.id,
                images: oldStory.images,
                previewImage: oldStory.previewImage,
                title: oldStory.title,
                description: oldStory.description,
                isViewed: true
            )
            stories[index] = newStory
            action.send(.storiesNeedUpdate)
        }
    }
}
