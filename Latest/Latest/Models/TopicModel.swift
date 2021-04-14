//
//  TopicModel.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import Foundation

// Used for Griding
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
