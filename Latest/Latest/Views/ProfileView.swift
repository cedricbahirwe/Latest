//
//  ProfileView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 0) {
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
            
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Button(action: {
                        
                    }) {
                        Text("Log In")
                            .font(Font.body.weight(.semibold))
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                            .border(Color.systemWhite, width: 1.5)
                    }
                    .padding()
                    .padding(.vertical)
                    
                    ProfileItem(label: "Manage Accounts")
                    Section(header:
                                Text("NOTIFICATIONS")
                                .font(Font.callout.weight(.semibold))
                                .padding(.vertical)
                                .padding(.horizontal, 12)
                    ) {
                        ProfileItem(label: "Enable Notifications")
                    }
                    Section(header:
                                Text("CONTENT PREFERENCES")
                                .font(Font.callout.weight(.semibold))
                                .padding(.vertical)
                                .padding(.horizontal, 12)
                    ) {
                        ProfileItem(label: "Clear Cached Content")
                    }
                    Section(header:
                                Text("SUPPORT")
                                .font(Font.callout.weight(.semibold))
                                .padding(.vertical)
                                .padding(.horizontal, 12)
                    ) {
                        ProfileItem(label: "Provide Feedback")
                        ProfileItem(label: "Rate App")
                        ProfileItem(label: "Share App")
                    }
                    
                    Section(header:
                                Text("SUPPORT")
                                .font(Font.caption.weight(.semibold))
                                .padding(12)
                    ) {
                        ProfileItem(label: "Privacy Policy")
                        ProfileItem(label: "Version 1.0")
                        ProfileItem(label: "Credits")
                    }
                }
            }
            .foregroundColor(.systemWhite)
            .frame(maxWidth:.infinity, alignment: .topLeading)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.mainColor, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)

            )
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
extension ProfileView {
    private struct ProfileItem: View {
        let label: String
        let hasBg: Bool = true
        var body: some View {
            HStack {
                Text(label)
                    .font(Font.callout.weight(.light))
                Spacer()
                
                Image(systemName: "chevron.right")
                
            }
            .font(Font.callout.weight(.light))
            .padding(12)
            .background(Color.primary.opacity(0.3))
        }
    }

}
