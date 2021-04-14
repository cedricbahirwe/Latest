//
//  TopicModel.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

// Used for Grid Layout
struct TopicsModeler {
    
    var allTopics: [Topics]
    var index: Int
    init(allTopics: [Topics] = [Topics(values: [])], index: Int = 0) {
        self.allTopics = allTopics
        self.index = index
        energize()
    }
    
    mutating func energize() {
        for topic in Topic.examples {
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
        let emoji: CGFloat = 8
        let paddings: CGFloat = 30
        return topic.title.widthOfString(usingFont: .systemFont(ofSize: 18, weight: .bold)) + margins + paddings + emoji
    }
    
}
struct Topics: Identifiable, Hashable {
    var id = UUID()
    var values: [Topic]
}

struct Topic: Identifiable, Hashable {
    var id = UUID()
    var emoji: String
    var title: String
    
    static let examples = [
        Topic(emoji: "💵", title: "Startups"),
        Topic(emoji: "🚙", title: "Mobility"),
        Topic(emoji: "🚀", title: "Space"),
        Topic(emoji: "🤖", title: "Robotics and AI"),
        Topic(emoji: "🔐", title: "Security"),
        Topic(emoji: "☁️", title: "Enterprise"),
        Topic(emoji: "🎓", title: "Education"),
        Topic(emoji: "🏛", title: "Policy"),
        Topic(emoji: "🔬", title: "Science"),
        Topic(emoji: "📊", title: "Finance"),
        Topic(emoji: "🎮", title: "Gaming"),
        Topic(emoji: "⌚️", title: "Hardware"),
        Topic(emoji: "📺", title: "Entertainment and Media"),
        Topic(emoji: "💼", title: "Work"),
        Topic(emoji: "🎃", title: "Events"),
    ]
}
