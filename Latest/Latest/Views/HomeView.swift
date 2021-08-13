//
//  HomeView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var data: AppManagerViewModel
    private var nextPageView: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .mainColor))
            .scaleEffect(1.2)
            
            .frame(maxWidth: .infinity)
            .frame(height: 30)
            .onAppear() {
                
                data.currentPage += 1
            }
    }
    
    var articles: [NewsApiArticle] {
        data.allArticles.isEmpty ? data.placeholders : data.allArticles
    }
    var headLine: NewsApiArticle {
        data.headLines.isEmpty ? .defaultTopNews : data.headLines.randomElement()!
    }
    var body: some View {
        VStack(spacing: 0) {
            NavBarView()
            List {
                TopHeaderView(news: headLine)
                    .onAppear(perform: data.getHeadLines)
                    .redacted(reason: data.headLines.isEmpty ? .placeholder : [])
                
                ForEach(articles, content: NewsRowView.init)
                    .redacted(reason: data.allArticles.isEmpty ? .placeholder : [])
                
                if data.shouldDisplayNextPage {
                    nextPageView
                }
            }
            .listStyle(PlainListStyle())
            
            
        }
        .onAppear(perform: data.getAllNews)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppManagerViewModel())
    }
}

extension HomeView {
    
    struct TopHeaderView: View {
        let news: NewsApiArticle
        var body: some View {
            
            VStack(alignment: .leading, spacing: 8) {
                
                
//                Text("Security")
//                    .textCase(.uppercase)
//                    .font(Font.caption.weight(.semibold))
//                    .foregroundColor(Color.systemWhite.opacity(0.8))
                Text(news.title)
                    .font(Font.title3.bold())
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                
                HStack(spacing: 5) {
                    if let author = news.author {
                        Text("By \(author)")
                        Color.systemWhite
                            .frame(width: 5, height: 5)
                    }
                    Text(news.timesAgo)
                    
                    if let url = URL(string: news.url) {
                        Link(news.url, destination: url)
                            .lineLimit(1)
                            .padding(6)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .foregroundColor(.mainColor)
                            .frame(maxWidth: 200)
                    }
                    
                }
                .font(Font.caption2.weight(.light))
                
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.mainColor.opacity(0.6))
            .frame(height: 220, alignment: .bottom)
            .background(
                ZStack {
                    if let imageurl = news.urlToImage {
                        RemoteImage(url: imageurl)
                            .scaledToFill()
                            .clipped()
                    }
                }
            )
            .background(Color.mainColor.opacity(0.3))
            .clipped()
        }
    }
    
}
