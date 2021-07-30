//
//  ContentView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data: AppManagerViewModel
    var body: some View {
        ZStack(alignment: .top) {
            
            TabView(selection: $data.selectedHomeTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "newspaper.fill")
                        
                    }.tag(1)
                ConfigurationsView()
                    .tabItem {
                        Image(systemName: "star.square.fill")
                        
                    }.tag(2)
            }
            .accentColor(.mainColor)
            .sheet(isPresented: data.showBookmarkView ? $data.showBookmarkView : $data.showProfileView) {
                if data.showBookmarkView {
                    BookmarkedView()
                        .environmentObject(data)
                } else {
                    ProfileView()
                }
            }
            
            
            HStack {
                HStack {
                    Text("Latest")
                    Spacer()
                    Text("Now")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                Text("")
            }
            .padding(10)
            .frame(height: 80, alignment: .topLeading)
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemGroupedBackground).ignoresSafeArea())
            .cornerRadius(12)
            .padding(.horizontal, 10)
            .preferredColorScheme(.dark)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppManagerViewModel())
        //        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
