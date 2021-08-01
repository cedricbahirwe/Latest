//
//  NewsApiModel.swift
//  Latest
//
//  Created by Cédric Bahirwe on 01/08/2021.
//

import Foundation

struct NewsApiModel: Decodable {
    var status: String
    var totalResults: Int
    var articles: [NewsApiArticle]
}

struct NewsApiArticle: Decodable, Identifiable {
    let source: NewsApiSource
    let author: String?
    var title: String = ""
    var description: String? = ""
    var url: String = ""
    var urlToImage: String?
    var publishedAt: String = ""
    var content: String? = ""
    
    
    var id: String {
        title + url
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
