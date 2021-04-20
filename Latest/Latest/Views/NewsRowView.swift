//
//  NewsRowView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

struct NewsRowView: View {
    let news: NewsApiArticle
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Security")
                        .foregroundColor(.green)
                        .textCase(.uppercase)
                        .font(Font.caption.weight(.semibold))
                    
                    Spacer()
                    Image(systemName: "bookmark")
                        .hidden()
                    Image("small-bookmark")
                        .resizable()
                        .frame(width: 16, height: 15)
                        .foregroundColor(.gray)
                    
                }
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text(news.title)
                            .font(Font.body.weight(.semibold))
                        HStack(spacing: 5) {
                            Text("By \(news.author ?? "Unknown")")
                            Color.gray
                                .frame(width: 3, height: 3)
                            Text("\(news.publishedAt)")
                            
                        }
                        .font(Font.caption2.weight(.light))
                        .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    if let imageurl = news.urlToImage {
                        RemoteImage(url: imageurl)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 60)
                            .clipped()
                            .background(Color.gray)
                        
                    } else {
                        Color.gray
                            .frame(width: 100, height: 60)
                            .background(Color.gray)
                        
                    }
                }
            }
            .padding(10)
            Color.secondary.frame(height: 1)
        }
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowView(news: .defaultTopNews)
            .previewLayout(.fixed(width: 400, height: 200))
            .preferredColorScheme(.dark)
    }
}
