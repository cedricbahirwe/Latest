//
//  BookmarkedView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 15/04/2021.
//

import SwiftUI

struct BookmarkedView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 0) {
            
            SheetHeaderView()
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
        }
    }
    
}

struct BookmarkedView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedView()
    }
}

