//
//  ConfigurationsView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

struct ConfigurationsView: View {
    @State var selectedTab: TabBarView.Tabs = .foryou {
        didSet {
            // Store locally
        }
    }
    
    private let topics: [Topic] = []
    @State var selectedTopics =  Set<Topic>()
    
    private let colums: [GridItem] = [
        GridItem(.adaptive(minimum: 80))
    ]
    var body: some View {
        VStack(spacing: 0) {
            //            NavBarView()
            //            TabBarView(selectedTab: $selectedTab)
            //            ForyouView()
            //            NotificationView()
            VStack {
                Text("Subscribe to topics of interest to surface the stories you want to read")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50)
                ScrollView {
                    LazyVGrid(columns: colums, spacing: 8) {
                        ForEach(Topic.examples) { topic in
                            Text(topic.title)
                                .font(Font.body.weight(.light))
                                .foregroundColor(
                                    selectedTopics.contains(topic) ?
                                        Color.primary :
                                        Color.systemWhite
                                )
                                .lineLimit(1)
                                .minimumScaleFactor(0.85)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .border(Color.systemWhite, width: 1)
                                .background(
                                    selectedTopics.contains(topic) ?
                                        Color.systemWhite :
                                        Color.clear
                                )
                                .layoutPriority(1)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation {
                                        if selectedTopics.contains(topic) {
                                            selectedTopics.remove(topic)
                                        } else {
                                            selectedTopics.insert(topic)
                                        }
                                    }
                                }
                        }
                        
                    }
                }
            }
            .padding(.top, 40)
        }
        .foregroundColor(.systemWhite)
        .background(Color.mainColor)
    }
}

struct ConfigurationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationsView()
    }
}

struct TabBarView: View {
    
    public enum Tabs: String, CaseIterable {
        case foryou = "For you"
        case notification = "Notification"
        case topics = "Topics"
    }
    
    @Binding var selectedTab: Tabs
    
    @Namespace private var animation
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                Text(tab.rawValue)
                    .textCase(.uppercase)
                    .font(Font.caption.bold())
                    .padding(.vertical, 15)
                    .overlay(
                        ZStack {
                            if selectedTab == tab {
                                Color.systemWhite
                                    .frame(height: 5)
                                    .matchedGeometryEffect(id: "Tab", in: animation)
                            } else {
                                Color.clear
                                    .frame(height: 5)
                            }
                            
                        }, alignment: .bottom
                    )
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedTab = tab
                        }
                    }
            }
        }
        .foregroundColor(.systemWhite)
        .font(.system(size: 16, weight: .light))
        .frame(maxWidth: .infinity)
        .padding(.bottom, 8)
        .background(Color.mainColor)
    }
}

struct ForyouView: View {
    var body: some View {
        VStack {
            Spacer()
            Group {
                Text("Find stories relevant to the\ntopics of interest")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                Button(action: {
                    
                }, label: {
                    Text("SELECT YOUR TOPICS")
                        .font(Font.caption.bold())
                        .foregroundColor(.mainColor)
                })
            }
            .padding(4)
            
            Spacer()
        }
    }
}

struct NotificationView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("NotificationView")
            Spacer()
        }
    }
}

