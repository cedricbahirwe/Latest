//
//  NewsRowView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

struct NewsRowView: View {
    let news: News
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Text(news.category)
                        .foregroundColor(.green)
                        .textCase(.uppercase)
                        .font(Font.caption.weight(.semibold))

                    Spacer()
                    Image(systemName: "bookmark")
                        .foregroundColor(.gray)
//                        .imageScale(.small)
                }
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text(news.title)
                            .font(Font.body.weight(.semibold))
                        HStack(spacing: 5) {
                            Text("By \(news.author)")
                            Color.gray
                                .frame(width: 3, height: 3)
                            Text("\(news.timeAgoDisplay)")

                        }
                        .font(Font.caption2.weight(.light))
                        .foregroundColor(.gray)
                    }
                    Spacer()
                    Image("3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 60)
                        .background(Color.gray)
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
