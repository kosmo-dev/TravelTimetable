//
//  Story.swift
//  TravelTimetable
//
//  Created by Вадим Кузьмин on 04.04.2024.
//

import Foundation

struct Story: Identifiable {
    let id: String
    let images: [String]
    let previewImage: String
    let title: String
    let description: String

    static let mock = [
        Story(id: "1", images: ["story1-0", "story1-1"], previewImage: "storyPreview1", title: "Story 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        Story(id: "2", images: ["story2-0", "story2-1"], previewImage: "storyPreview2", title: "Story 2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        Story(id: "3", images: ["story3-0", "story3-1"], previewImage: "storyPreview3", title: "Story 3", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        Story(id: "4", images: ["story4-0", "story4-1"], previewImage: "storyPreview4", title: "Story 4", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        Story(id: "5", images: ["story5-0", "story5-1"], previewImage: "storyPreview5", title: "Story 5", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        Story(id: "6", images: ["story6-0", "story6-1"], previewImage: "storyPreview6", title: "Story 6", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        Story(id: "7", images: ["story7-0", "story7-1"], previewImage: "storyPreview7", title: "Story 7", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        Story(id: "8", images: ["story8-0", "story8-1"], previewImage: "storyPreview8", title: "Story 8", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        Story(id: "9", images: ["story9-0", "story9-1"], previewImage: "storyPreview9", title: "Story 9", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
    ]
}
