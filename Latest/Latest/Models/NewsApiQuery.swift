//
//  NewsApiQuery.swift
//  Latest
//
//  Created by Cédric Bahirwe on 31/07/2021.
//

import Foundation


struct NewsApiQuery {
    
    private  let BaseUrl = "https://newsapi.org/v2/"
    private let ApiKey = "117ed8864197464aac7e5f910a49fc77"
    enum SortingKey: String { case popularity }
    enum TopHeadLineCategory: Equatable {
        
        case country(iso: String), source(src: String)
        
        var value: String {
            switch self {
            case .country(let iso):
                return iso.description
            case .source(let src):
                return src
            }
        }
        
    }
    
    enum FilteringKey: String { case everything, topHeadlines = "top-headlines" }
    
    let term: String
    let filter: FilteringKey
    let sorting: SortingKey?
    let startDate: Date
    var page: Int = 1
    
    var topheadLine: TopHeadLineCategory? = nil
    
    private func getEverythingQuery() -> String {
        basePath + "q=\(term.replacingOccurrences(of: " ", with: "-"))" + "&from=\(stringDate)" + "&sortBy=\(sorting!.rawValue)" + "&apiKey=\(ApiKey)" + "&page=\(page)"
    }
    
    private func getTopheadLinesQuery(by category: TopHeadLineCategory) -> String {
        let middlePath = category == .country(iso: category.value) ? "country" : "sources"
        return basePath + "\(middlePath)=\(category.value)" + "&apiKey=\(ApiKey)" + "&page=\(page)"
    }
    
    private var basePath: String {
        BaseUrl + "\(filter.rawValue)?"
    }
    var fullStringQuery: String {
       (topheadLine == nil && filter == .everything) ?  getEverythingQuery() : getTopheadLinesQuery(by: topheadLine!)
    }
    private var stringDate: String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd"
        return dateformatter.string(from: startDate)
    }
}
