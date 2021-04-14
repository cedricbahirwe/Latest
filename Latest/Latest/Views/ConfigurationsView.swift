//
//  ConfigurationsView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

struct ConfigurationsView: View {
    var body: some View {
        VStack(spacing: 0) {
            NavBarView()
            TabBarView()
            Spacer()
        }
    }
}

struct ConfigurationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationsView()
    }
}

struct TabBarView: View {
    
    enum Tabs: String, CaseIterable {
        case foryou = "For you"
        case notification = "Notification"
        case topics = "Topics"
    }
    
    @State private var selectedTab: Tabs = .foryou
    
    @Namespace var animation
    
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
            .background(Color.militaryGreen)
    }
}
