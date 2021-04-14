//
//  AppManagerViewModel.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

class AppManagerViewModel: ObservableObject {
    @Published public var showProfileView: Bool = false
    @Published public var showBookmarkView: Bool = false
    @Published public private(set) var allNews: [News] = News.examples
    
    public let topics: [Topic] = Topic.examples
    
    
}
