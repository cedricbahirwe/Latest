//
//  NewsModel.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import Foundation

struct News: Identifiable, Hashable {
    let id = UUID()
    var category: String
    var title: String
    var description: String
    var author: String
    var createdDate: Date = Date(timeIntervalSinceNow: -20)
    var isBookmarked: Bool = false
    
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


struct NewsApiModel: Decodable {
    var status: String
    var totalResults: Int
    var articles: [NewsApiArticle]
}

struct NewsApiArticle: Decodable, Identifiable {
    let source: NewsApiSource
    let author: String?
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var urlToImage: String?
    var publishedAt: String = ""
    var content: String = ""
    
    
    var id: UUID {
        UUID(uuidString: title + content) ?? UUID()
    }
    
    var timesAgo: String {
        publishedDate().timeAgoDisplay
    }
    
    
    private func publishedDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date =  dateFormatter.date(from: publishedAt) {
            return date
        }
        return Date()
    }
    static var defaultTopNews = NewsApiArticle(source: .default, author: nil, title: "", description: "", url: "", urlToImage: nil, publishedAt: "", content: "")
}

struct NewsApiSource: Decodable {
    let source: String?
    let name: String?
    
    static let `default` = NewsApiSource(source: nil, name: nil)
}


extension Date {
    var timeAgoDisplay: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
