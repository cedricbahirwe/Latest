//
//  HomeView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

struct HomeView: View {
    let topNews: News = .defaultTopNews
    @EnvironmentObject var data: AppManagerViewModel
    var body: some View {
        VStack(spacing: 0) {
            NavBarView()
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    
                    ForEach(data.allNews, content: NewsRowView.init)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppManagerViewModel())
    }
}

struct NavBarView: View {
    
    @EnvironmentObject var data: AppManagerViewModel
    let bgColor: Color = Color.mainColor
    private let title: String = "Latest"
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .imageScale(.large)
                .onTapGesture {
                    data.showProfileView.toggle()
                }
            Spacer()
            Text("Latest")
                .font(Font.title2.weight(.bold))
            Spacer()
            Image(systemName: "bookmark.circle")
                .imageScale(.large)
                .onTapGesture {
                    data.showBookmarkView.toggle()
                }
        }
        .foregroundColor(Color(.systemBackground))
        .padding()
        .frame(height: 48)
        .background(bgColor.ignoresSafeArea(.all))
    }
}

struct TopHeaderView: View {
    let news: News
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("2")
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Security")
                    .textCase(.uppercase)
                    .font(Font.caption.weight(.semibold))
                    .foregroundColor(Color.systemWhite.opacity(0.8))
                Text("FBI launches operation to remove backdoors from hacked Hello Kigali servers")
                    .font(Font.title.bold())
                HStack(spacing: 5) {
                    Text("By Cédric Bahirwe")
                    Color.systemWhite
                        .frame(width: 5, height: 5)
                    Text(news.timeAgoDisplay)
                    
                }
                .font(Font.caption2.weight(.light))
                
            }
            .foregroundColor(.systemWhite)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.mainColor.opacity(0.8))
            .padding(.trailing, 10)
        }
        .background(Color.mainColor.opacity(0.3))
        .frame(minHeight: 150, alignment: .bottom)
        
    }
}
