//
//  ConfigurationsView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

struct ConfigurationsView: View {
    @EnvironmentObject var app: AppManagerViewModel
    @State private var offsetX: CGFloat = .zero
    private let width = UIScreen.main.bounds.size.width
    
    var body: some View {
        VStack(spacing: 0) {
            NavBarView()
            TabBarView(selectedTab: $app.selectedHeaderTab)
            
            
            GeometryReader { geo in
                HStack(spacing: 0) {
                    ForyouView
                        .frame(width: geo.frame(in: .global).width)
                    NotificationView
                        .frame(width: geo.frame(in: .global).width)
                    TopicsView()
                        .frame(width: geo.frame(in: .global).width)
                }
                .offset(x: offsetX)
                .highPriorityGesture(
                    DragGesture()
                        .onEnded(app.updateTabs)
                )
            }
            .animation(.default)
            
        }
        .onChange(of: app.selectedHeaderTab, perform: updateLayout)
        
    }
    
    private func updateLayout(tab: Tabs) {
        switch tab {
        case .foryou:
            offsetX = 0
        case .notification:
            offsetX = -width
        case .topics:
            offsetX = -width*2
        }
    }
    
}

struct ConfigurationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationsView()
            .environmentObject(AppManagerViewModel())
    }
}

extension ConfigurationsView {
    public enum Tabs: String, CaseIterable {
        case foryou = "For you"
        case notification = "Notification"
        case topics = "Topics"
    }
    private struct TabBarView: View {
        
        @Binding var selectedTab: ConfigTabs
        
        @Namespace private var animation
        
        var body: some View {
            HStack(spacing: 20) {
                ForEach(ConfigTabs.allCases, id: \.self) { tab in
                    Text(tab.rawValue)
                        .textCase(.uppercase)
                        .font(Font.system(size: 16).bold())
                        .padding(.vertical, 15)
                        .overlay(
                            ZStack {
                                if selectedTab == tab {
                                    Color.white
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
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .light))
            .frame(maxWidth: .infinity)
            .padding(.bottom, 8)
            .background(Color.mainColor)
        }
    }
    
    private var ForyouView: some View {
        VStack {
            Spacer()
            Group {
                Text("Find stories relevant to the\ntopics of interest")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                Button(action: {
                    app.selectedHeaderTab = .topics
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
    
    private var NotificationView: some View {
        VStack {
            Spacer()
            Text("NotificationView")
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private struct TopicsView: View {
        private let size = UIScreen.main.bounds.size
        private let topics: [Topic] = []
        
        @State private var index: Int = 0
        @State private var selectedTopics =  Set<Topic>()
        @State private var allTopics: [Topics] = TopicsModeler.shared.allTopics
        var body: some View {
            VStack {
                Text("Subscribe to topics of interest to surface the stories you want to read")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50)
                    .foregroundColor(.white)
                ScrollView {
                    VStack(spacing: 8)  {
                        ForEach(allTopics) { allTopic in
                            HStack(spacing: 12) {
                                ForEach(allTopic.values) { topic in
                                    HStack(spacing: 1) {
                                        if selectedTopics.contains(topic) {
                                            Text(topic.emoji)
                                        }
                                        Text(topic.title)
                                            
                                            .foregroundColor(
                                                selectedTopics.contains(topic) ?
                                                    .mainColor :
                                                    .white
                                            )
                                        
                                    }
                                    .font(.system(size: 17, weight: .light))
                                    .padding(.horizontal, selectedTopics.contains(topic) ? 15 : 18)
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
                            .minimumScaleFactor(0.65)

                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                }
            }
            .padding(.top, 25)
            .background(Color.mainColor)

        }
    }
}

