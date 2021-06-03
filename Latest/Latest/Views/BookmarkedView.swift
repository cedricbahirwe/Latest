//
//  BookmarkedView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 15/04/2021.
//

import SwiftUI

struct BookmarkedView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var data: AppManagerViewModel
    var body: some View {
        VStack(spacing: 0) {
            
            SheetHeaderView()
            
            if data.bookmarkedNews.isEmpty {
                Spacer()
                Group {
                    Text("Your saved stories will live here.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("START EXPLORING")
                            .font(Font.caption.bold())
                            .foregroundColor(.mainColor)
                    })
                }
                .padding(4)
                Spacer()
            } else {
                ScrollView {
                    ForEach(data.bookmarkedNews, content: NewsRowView.init)
                }
                
            }
 
        }
    }
    
}

struct BookmarkedView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedView()
            .environmentObject(AppManagerViewModel())
    }
}

