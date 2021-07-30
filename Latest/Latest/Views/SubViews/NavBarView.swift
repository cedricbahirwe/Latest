//
//  NavBarView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 15/04/2021.
//

import SwiftUI

struct NavBarView: View {
    @EnvironmentObject var data: AppManagerViewModel
    let bgColor: Color = Color.mainColor
    private var title: String {
        if data.allArticles.isEmpty == false {
            return "\(data.allArticles.count) Latests"
        }
        return "Latest"
    }
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .imageScale(.large)
                .onTapGesture {
                    data.showProfileView.toggle()
                }
            Spacer()
            if data.isFetchingMore {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(.lightGray)))
                    .scaleEffect(1.3)
            } else {
                Text(title)
                    .font(Font.title2.weight(.bold))
                    .animation(.easeIn)
            }
            Spacer()
            Image(systemName: "bookmark.circle")
                .imageScale(.large)
                .onTapGesture {
                    data.showBookmarkView.toggle()
                }
        }
        .foregroundColor(.white)
        .padding()
        .frame(height: 48)
        .background(bgColor.ignoresSafeArea(.all))
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
            .environmentObject(AppManagerViewModel())
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
