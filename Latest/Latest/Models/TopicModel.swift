//
//  TopicModel.swift
//  Latest
//
//  Created by CΓ©dric Bahirwe on 14/04/2021.
//

import SwiftUI

// Used for Grid Layout
struct TopicsModeler {
    
    static let shared = TopicsModeler()
    
    var allTopics: [Topics] = []
    var index: Int = 0
    
    init() {
        allTopics = [Topics(values: [])]
        index = 0
        initializeTopics()
    }
    
    mutating func initializeTopics(_ topics: [Topic] = Topic.examples) {
        for topic in topics {
            addTopic(topic)
        }
    }

     mutating func addTopic(_ topic: Topic) {
        let itemSize = allTopics[index].values.map(topicsize).reduce(0, +)
        
        let topicSize = topicsize(topic)
        let containerWidth = UIScreen.main.bounds.size.width - 20
        if itemSize + topicSize <= containerWidth {
            allTopics[index].values.append(topic)
        } else {
            index += 1
            allTopics.append(.init(values: []))
            allTopics[index].values.append(topic)
        }
    }

    private func topicsize(_ topic: Topic) -> CGFloat {
        let margins: CGFloat = 5
        let emoji: CGFloat = 10
        
        let paddings: CGFloat = 30
        return topic.title.widthOfString(usingFont: .systemFont(ofSize: 18, weight: .bold)) + margins + paddings + emoji
    }
    
}
struct Topics: Identifiable, Hashable {
    var id = UUID()
    var values: [Topic]
}

struct Topic: Identifiable, Hashable {
    let id = UUID()
    let emoji: String
    let title: String
    
    static let examples = [
        Topic(emoji: "π΅", title: "Startups"),
        Topic(emoji: "π", title: "Mobility"),
        Topic(emoji: "π", title: "Space"),
        Topic(emoji: "π€", title: "Robotics and AI"),
        Topic(emoji: "π", title: "Security"),
        Topic(emoji: "βοΈ", title: "Enterprise"),
        Topic(emoji: "π", title: "Education"),
        Topic(emoji: "π", title: "Policy"),
        Topic(emoji: "π¬", title: "Science"),
        Topic(emoji: "π", title: "Finance"),
        Topic(emoji: "π?", title: "Gaming"),
        Topic(emoji: "βοΈ", title: "Hardware"),
        Topic(emoji: "πΊ", title: "Entertainment and Media"),
        Topic(emoji: "πΌ", title: "Work"),
        Topic(emoji: "π", title: "Events"),
    ]
}
