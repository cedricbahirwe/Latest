//
//  NewsApiQuery.swift
//  Latest
//
//  Created by Cédric Bahirwe on 31/07/2021.
//

import Foundation


struct NewsApiQuery {
    static let APIKey = "117ed8864197464aac7e5f910a49fc77"
    static var stringPath = "https://newsapi.org/v2/"
    static var BaseUrl = URL(string: stringPath)!
    
    init(api: LatestEndPoints.NewsAPI) {
        let defaultPath = api.rawValue + "?"
        configureDefault(defaultPath)
        
    }
    private(set) var request = URLComponents(string: stringPath)!
    
    
    mutating func configureDefault(_ basePath: String) {
        NewsApiQuery.stringPath +=  basePath
        NewsApiQuery.BaseUrl = URL(string: NewsApiQuery.stringPath)!
        request = URLComponents(string: NewsApiQuery.stringPath)!

    }
    
    enum SortingKey: String { case popularity }
    struct NewsAPIHeader {
        let value: String
        let key: HeaderKey
        
        typealias Keys = HeaderKey
        enum HeaderKey: String {
            case sortBy, from, country, page
            
            case term = "q"
            case APIKey = "apiKey"
        }
        
    }
    
}

extension Date {
    var yyyyMMdd: String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd"
        return dateformatter.string(from: self)
    }
}
extension NewsApiQuery.NewsAPIHeader {
    public static func sort(by type: NewsApiQuery.SortingKey) -> Self {
        .init(value: type.rawValue, key: .sortBy)
    }
    public static func from(_ date: Date) -> Self {
        .init(value: date.yyyyMMdd, key: .from)
    }
    public static func term(_ q: String) -> Self {
        .init(value: q, key: .term)
    }
    public static func country(_ iso: String) -> Self {
        .init(value: iso, key: .country)
    }
    public static func apiKey(_ value: String) -> Self {
        .init(value: value, key: .APIKey)
    }
    
    public static func page(_ value: String) -> Self {
        .init(value: value, key: .page)
    }
}
extension NewsApiQuery {
    public mutating func addHeaders(_ headers: [NewsAPIHeader]) {
        request.queryItems = headers.map { .init(name: $0.key.rawValue, value: $0.value) }
        let apiKey = URLQueryItem(name: NewsAPIHeader.Keys.APIKey.rawValue, value: Self.APIKey)
        request.queryItems?.append(apiKey)

        // More Info on : https://stackoverflow.com/questions/27723912/swift-get-request-with-parameters
//        request.percentEncodedQuery = request.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    }
}

