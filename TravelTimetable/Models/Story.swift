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
    let isViewed: Bool
    
    init(id: String, images: [String], previewImage: String, title: String, description: String, isViewed: Bool) {
        self.id = id
        self.images = images
        self.previewImage = previewImage
        self.title = title
        self.description = description
        self.isViewed = isViewed
    }
    
    
    /// Mock initializer
    init(id: String) {
        self.id = id
        self.images = ["story\(id)-0", "story\(id)-1"]
        self.previewImage = "storyPreview\(id)"
        self.title = "Story \(id)"
        self.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        self.isViewed = false
    }
}
