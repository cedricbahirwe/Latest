//
//  AppManagerViewModel.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import Foundation
import SwiftUI

typealias ConfigTabs = ConfigurationsView.Tabs


class AppManagerViewModel: ObservableObject {
    @Published public var selectedHomeTab: Int = 1
    @Published public var showProfileView: Bool = false
    @Published public var showBookmarkView: Bool = false
    
    @Published public var alertData: AlertModel? = nil
    
    @Published public var isFetchingMore: Bool = false
    
    @Published var selectedHeaderTab: ConfigTabs = .foryou {
        didSet {
            // Store locally
        }
    }
    
    public var currentPage: Int  = 1 {
        didSet {
            getAllNews()
        }
    }
    public var shouldDisplayNextPage: Bool {
        // Limit for Developer account is 100 articles, 20 per page
        if allArticles.isEmpty == false, currentPage < 5 {
            return true
        }
        return false
    }
    
    
    @Published public private(set) var headLines: [NewsApiArticle] = []
    
    @Published public private(set) var allArticles: [NewsApiArticle] = []
    public var placeholders: [NewsApiArticle] = Array(repeating: NewsApiArticle(
                                                        source: NewsApiSource(source: nil,  name: nil),
                                                        author: nil, urlToImage: nil), count: 10)
    @Published public private(set) var bookmarkedNews: [NewsApiArticle] = []
    
    
    
    public let topics: [Topic] = Topic.examples
    
    
    
    
    public func getAllNews() {
        isFetchingMore = true
        let fetchedpage = currentPage
        
        let weekAgoDate = Date(timeIntervalSinceNow: -86400*10)
        let everythingQuery = NewsApiQuery(term: "Apple", filter: .everything, sorting: .popularity,
                                           startDate: weekAgoDate)

        GetRequest<NewsApiModel>(everythingQuery.fullStringQuery)
            .requestData { [weak self] result in
                DispatchQueue.main.async {
                    self?.isFetchingMore = false
                    switch result {
                    case .success(let news):
                        if fetchedpage > 1 {
                            self?.allArticles.append(contentsOf: news.articles)
                        } else {
                            self?.allArticles = news.articles
                        }
                    case .failure(let error):
                        self?.alertData = AlertModel(title: "News APi Error", body: error.message)                        
                        print(error.localizedDescription)
                    }
                }
            }
    }
    
    public func getHeadLines() {
        isFetchingMore = true
        let date = Date(timeIntervalSinceNow: -86400*10)
        let topHealine = NewsApiQuery(term: "Apple", filter: .topHeadlines,
                                      sorting: .popularity, startDate: date,
                                      topheadLine: .country(iso: "us"))
        GetRequest<NewsApiModel>(topHealine.fullStringQuery)
            .requestData { [weak self] result in
                DispatchQueue.main.async {
                    self?.isFetchingMore = false
                    switch result {
                    case .success(let news):
                        print(news.articles.first)
                        self?.headLines = news.articles
                    case .failure(let error):
                        self?.alertData = AlertModel(title: "Headlines Updates", body: error.message)
                        print(error.localizedDescription)
                    }
                }
                
            }
    }
    
}

// MARK: - Logic Methods
extension AppManagerViewModel {
    
    public func updateBookmarks(_ news: NewsApiArticle) {
        if let index = bookmarkedNews.firstIndex(where: { $0.id == news.id}) {
            bookmarkedNews.remove(at: index)
        } else {
            bookmarkedNews.append(news)
        }
    }
    
    public func isBookMarked(_ news: NewsApiArticle) -> Bool {
        if let _ = bookmarkedNews.firstIndex(where: { $0.id == news.id}) {
            return true
        }
        return false
    }
}


// MARK: - Layout Methods
extension AppManagerViewModel {
    public func updateTabs(with swipeValue: DragGesture.Value) {
        
        if (-swipeValue.translation.width > 50)  {
            switch selectedHeaderTab {
            case .foryou:
                selectedHeaderTab = .notification
            case .notification:
                selectedHeaderTab = .topics
            default: break
            }
        }
        
        if (swipeValue.translation.width > 50) {
            switch selectedHeaderTab {
            case .topics:
                selectedHeaderTab = .notification
            case .notification:
                selectedHeaderTab = .foryou
            default: break
            }
        }
        
    }
    
}
