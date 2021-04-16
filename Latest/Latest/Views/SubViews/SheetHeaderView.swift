//
//  SheetHeaderView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 15/04/2021.
//

import SwiftUI

struct SheetHeaderView: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "multiply")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.systemWhite)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }
        .padding(.horizontal)
        .frame(height: 48)
        .background(Color.mainColor.ignoresSafeArea())
    }
}

struct SheetHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeaderView()
            .previewLayout(.fixed(width: 400, height: 50))
    }
}
