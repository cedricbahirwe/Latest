//
//  ContentView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data: AppManagerViewModel
    @State private var showToast = false {
        didSet  {
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                showToast = false
            }
        }
    }
    var body: some View {
        ZStack(alignment: .top) {
            
            TabView(selection: $data.selectedHomeTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "newspaper.fill")
                        
                    }.tag(1)
                ConfigurationsView()
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                            showToast.toggle()
                        }
                    }
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
            
            
            VStack(alignment: .leading) {
                HStack {
                    Image("icon")
                        .resizable()
                        .foregroundColor(Color.mainColor)
                        .saturation(2)
                        .frame(width: 18, height: 18)
                    Text("Latest")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("Now")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                Text("A simple title for the notification")
                    .fontWeight(.semibold)
                Text("This is some somple comments about the notifications")
                    .font(.callout)
                    .lineLimit(1)
            }
            .padding(10)
            .frame(height: 90, alignment: .topLeading)
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemGroupedBackground).ignoresSafeArea())
            .cornerRadius(12)
            .padding(.horizontal, 10)
            .opacity(showToast ? 1 : 0)
            .offset(y: showToast ? 0 : -100-(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
            .transition(.move(edge: .top))
            .animation(.spring())
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
