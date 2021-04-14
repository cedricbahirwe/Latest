//
//  NewsModel.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import Foundation

struct News: Identifiable {
    let id = UUID()
    var category: String
    var title: String
    var description: String
    var author: String
    var createdDate: Date = Date(timeIntervalSinceNow: -20)
    
    static let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var timeAgoDisplay: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        return formatter.localizedString(for: createdDate, relativeTo: Date())
    }
    
    static let defaultTopNews = News(category: "Security", title: "FBI launches operation to remove backdoors from hacked Hello Kigali servers", description: "", author: "Cédric Bahirwe")
    
    static let examples: [News] = [
        .defaultTopNews,
        News(category: "Startups", title: "Grab a group discount and take your team to TC Sessions: Mobility 2021", description: "", author: "John Abouba"),
        News(category: "Startups", title: "Grab a group discount and take your team to TC Sessions: Mobility 2021", description: "", author: "John Abouba"),
        News(category: "Gaming", title: "Fortnite Epic completes made a $ 1B funding round", description: "", author: "Kevin Ha")
    ]
    
}
