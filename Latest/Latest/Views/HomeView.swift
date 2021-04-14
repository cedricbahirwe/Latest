//
//  HomeView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI


struct News: Identifiable {
    var id = UUID()
    var category: String
    var title: String
    var description: String
    var author: String
    var createdDate: Date = Date(timeIntervalSinceNow: -20)
    
     static let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var timeAgoDisplay: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        return formatter.localizedString(for: createdDate, relativeTo: Date())
    }
    
    static let defaultTopNews = News(category: "Security", title: "FBI launches operation to remove backdoors from hacked Hello Kigali servers", description: "", author: "Cédric Bahirwe")
    
}
struct HomeView: View {
    @State private var topNews: News = .defaultTopNews
    var body: some View {
        VStack(spacing: 0) {
            NavBarView()
            ZStack(alignment: .bottomLeading) {
                Image("2")
                    .resizable()
                    .scaledToFit()
                    .background(Color.militaryGreen.opacity(0.3))
                
                VStack(alignment: .leading) {
                    Text("Security")
                        .textCase(.uppercase)
                        .font(Font.caption.weight(.semibold))
                        .foregroundColor(Color.systemWhite.opacity(0.8))
                    Text("FBI launches operation to remove backdoors from hacked Hello Kigali servers")
                        .font(Font.title.bold())
                    HStack {
                        Text("By Cédric Bahirwe")
                        Color.systemWhite
                            .frame(width: 5, height: 5)
                        Text("\(topNews.timeAgoDisplay)")

                    }
                    .font(.caption2)
                    
                }
                .foregroundColor(.systemWhite)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(Color.militaryGreen.opacity(0.9))
                .padding(.trailing, 10)
            }
            .frame(minHeight: 200)
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct NavBarView: View {
    let bgColor: Color = Color.militaryGreen
    private let title: String = "Latest"
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .imageScale(.large)
            Spacer()
            Text("Latest")
                .font(Font.title2.weight(.bold))
            Spacer()
            Image(systemName: "bookmark.circle")
                .imageScale(.large)
        }
        .foregroundColor(Color(.systemBackground))
        .padding()
        .frame(height: 48)
        .background(bgColor.ignoresSafeArea(.all))
    }
}
