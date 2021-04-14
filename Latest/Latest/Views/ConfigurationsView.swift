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
    @State private var offsetX: CGFloat = .zero
    private let width = UIScreen.main.bounds.size.width
    
    var body: some View {
        VStack(spacing: 0) {
                    NavBarView()
            TabBarView(selectedTab: $selectedTab)
            
            GeometryReader { geo in
                HStack(spacing: 0) {
                    ForyouView()
                        .frame(width: geo.frame(in: .global).width)
                    NotificationView()
                        .frame(width: geo.frame(in: .global).width)
                    TopicsView()
                        .frame(width: geo.frame(in: .global).width)
                    
                }
                .offset(x: offsetX)
                .highPriorityGesture(
                    DragGesture()
                        .onEnded({ value in
                            print(value.translation.width)
                            if value.translation.width > 50 { // Minimum Drag
                                
                                print("Right")
                                updateTabs(left: false)
                            }
                            if -value.translation.width > 50 {
                                updateTabs(left: true)
                                print("Left")
                            }
                        })
                )
            }

        }
        .onChange(of: selectedTab, perform: updateLayout)
        .animation(.default)
        .foregroundColor(.systemWhite)
//        .background(Color.mainColor)
        
        
    }
    
    private func updateLayout(tab: TabBarView.Tabs) {
        switch tab {
        case .foryou:
            offsetX = 0
        case .notification:
            offsetX = -width
        case .topics:
            offsetX = -width*2
        }
    }
    
    private func updateTabs(left: Bool) {
        
        if left {
            
            switch selectedTab {
            case .foryou:
                selectedTab = .notification
            case .notification:
                selectedTab = .topics
            default: break
            }
        } else {
            switch selectedTab {
            case .topics:
                selectedTab = .notification
            case .notification:
                selectedTab = .foryou
            default: break
            }
        }
        
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
        HStack(spacing: 20) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                Text(tab.rawValue)
                    .textCase(.uppercase)
                    .font(Font.system(size: 16).bold())
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


struct Topics: Identifiable {
    var id = UUID()
    var values: [Topic]
    
}

struct TopicsView: View {
    private let size = UIScreen.main.bounds.size
    private let topics: [Topic] = []

    @State private var index: Int = 0
    @State private var selectedTopics =  Set<Topic>()
    @State private var allTopics: [Topics] = [Topics(values: [])]
    var body: some View {
        VStack {
            Text("Subscribe to topics of interest to surface the stories you want to read")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
            ScrollView {
                VStack(spacing: 8)  {
                    ForEach(allTopics) { allTopic in
                        HStack(spacing: 12) {
                            ForEach(allTopic.values) { topic in
                                
                                Text(topic.title)
                                    .font(.system(size: 17))
                                    .fontWeight(.light)
                                    .foregroundColor(
                                        selectedTopics.contains(topic) ?
                                            Color.primary :
                                            Color.systemWhite
                                    )
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 13)
                                    .border(Color.systemWhite, width: 1)
                                    .background(
                                        selectedTopics.contains(topic) ?
                                            Color.systemWhite :
                                            Color.clear
                                    )
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .lineLimit(1)
                .minimumScaleFactor(0.9)
                .onAppear(perform: energize)
            }
        }
        .padding(.top, 40)
        .background(Color.mainColor)

    }
    
    private func energize() {
        for topic in Topic.examples {
            addTopic(topic)
        }
    }
    
    private func addTopic(_ topic: Topic) {
        let itemSize = allTopics[index].values.map(topicsize).reduce(0, +)
        let topicSize = topicsize(topic)
        let containerWidth = size.width - 20
        if itemSize + topicSize <= containerWidth {
            allTopics[index].values.append(topic)
        } else {
            index += 1
            allTopics.append(.init(values: []))
            allTopics[index].values.append(topic)
        }
    }
    
    private func topicsize(_ topic: Topic) -> CGFloat {
        let margins: CGFloat = 5
        let paddings: CGFloat = 30
        return topic.title.widthOfString(usingFont: .systemFont(ofSize: 18, weight: .light)) + margins + paddings
    }
}
