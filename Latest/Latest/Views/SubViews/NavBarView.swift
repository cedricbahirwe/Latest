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

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
            .environmentObject(AppManagerViewModel())
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
