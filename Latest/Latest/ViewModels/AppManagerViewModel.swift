//
//  AppManagerViewModel.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

typealias ConfigTabs = ConfigurationsView.Tabs

class AppManagerViewModel: ObservableObject {
    @Published public var showProfileView: Bool = false
    @Published public var showBookmarkView: Bool = false
    
    @Published var selectedHeaderTab: ConfigTabs = .foryou {
        didSet {
            // Store locally
        }
    }
    @Published public private(set) var allNews: [News] = News.examples
    
    public let topics: [Topic] = Topic.examples
    
    
}

extension AppManagerViewModel {
    public func updateTabs(swipeLeft: Bool) {
        
        if swipeLeft {
            
            switch selectedHeaderTab {
            case .foryou:
                selectedHeaderTab = .notification
            case .notification:
                selectedHeaderTab = .topics
            default: break
            }
        } else {
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
