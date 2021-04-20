//
//  AppManagerViewModel.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

typealias ConfigTabs = ConfigurationsView.Tabs

class AppManagerViewModel: ObservableObject {
    @Published public var selectedHomeTab: Int = 1
    @Published public var showProfileView: Bool = false
    @Published public var showBookmarkView: Bool = false
    
    @Published var selectedHeaderTab: ConfigTabs = .foryou {
        didSet {
            // Store locally
        }
    }
    @Published public private(set) var allNews: [News] = News.examples
    @Published public private(set) var allArticles: [NewsApiArticle] = []
    public var placeholders: [NewsApiArticle] = Array(repeating: NewsApiArticle(
                                                        source: NewsApiSource(
                                                            source: nil,
                                                            name: nil),
                                                        author: nil,
                                                        urlToImage: nil),
                                                      count: 10)
    private var bookmarkedNews: Set<News>  {
        Set(allNews.filter(\.isBookmarked))
    }
    
    public let topics: [Topic] = Topic.examples
    
    
    public func getNewsAPi() {
        GetRequest<NewsApiModel>(baseUrl: "https://newsapi.org/v2/everything?q=Apple&from=2021-04-20&sortBy=popularity&apiKey=ca03cd8413224a368bf14ebc23303c74", .other)
            .get(completion: { [weak self] result in
                switch result {
                case .success(let news):
                    DispatchQueue.main.async {
                        print("loaded")
                        self?.allArticles = news.articles
                    }
                case .failure(let error):
                    
                    print(error.localizedDescription)
                }
            })
    }
    
}

// MARK: - Logic Methods
extension AppManagerViewModel {
    
    public func updateBookmarked(_ news: News) {
        if let index = allNews.firstIndex(where: { $0.id == news.id }) {
            allNews[index].isBookmarked.toggle()
        }
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
