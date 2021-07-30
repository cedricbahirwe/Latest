//
//  AppManagerViewModel.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

typealias ConfigTabs = ConfigurationsView.Tabs

struct AlertModel: Identifiable, Equatable {
    let id = UUID()
    var title: String 
    var body: String
    let type: String = "default"
    let duration: Double = 3.0 // Time to be displayed in seconds

}
//extension AlertModel: ExpressibleByNilLiteral {
//    init(nilLiteral: ()) {
//        self.init(title: "", body: "", duration: 0)
//    }
//
//
//}
class AppManagerViewModel: ObservableObject {
    @Published public var selectedHomeTab: Int = 1
    @Published public var showProfileView: Bool = false
    @Published public var showBookmarkView: Bool = false
    
    @Published public var alertData: AlertModel? = nil
    
    @Published var selectedHeaderTab: ConfigTabs = .foryou {
        didSet {
            // Store locally
        }
    }
    @Published public private(set) var allArticles: [NewsApiArticle] = []
    public var placeholders: [NewsApiArticle] = Array(repeating: NewsApiArticle(
                                                        source: NewsApiSource(
                                                            source: nil,
                                                            name: nil),
                                                        author: nil,
                                                        urlToImage: nil),
                                                      count: 10)
    @Published public private(set) var bookmarkedNews: [NewsApiArticle] = []
    
    
    
    public let topics: [Topic] = Topic.examples
    
    
    public func getNewsAPi() {
        GetRequest<NewsApiModel>(baseUrl: "https://newsapi.org/v2/everything?q=Apple&from=2021-05-20&sortBy=popularity&apiKey=ca03cd8413224a368bf14ebc23303c74", .other)
            .requestData { [weak self] result in
                switch result {
                case .success(let news):
                    DispatchQueue.main.async {
                        print("loaded")
                        withAnimation {
                            self?.allArticles = news.articles
                        }
                    }
                case .failure(let error):
                    self?.alertData = AlertModel(title: "News APi Error", body: error.localizedDescription)
                    print(error.localizedDescription)
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
