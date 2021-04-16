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
    private var bookmarkedNews: Set<News>  {
        Set(allNews.filter(\.isBookmarked))
    }
    
    public let topics: [Topic] = Topic.examples
    
    
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
