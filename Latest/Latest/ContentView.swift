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
            ToastAlertView(item: $data.alertData)
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

struct ToastAlertView: View {
    @Binding var item: AlertModel?
    var body: some View {
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
            if let value = item  {
                
                Text(value.title)
                    .fontWeight(.semibold)
                Text(value.body)
                    .font(.callout)
                    .lineLimit(1)
            }
        }
        .onChange(of: item, perform: { value in
            guard let value = value else { return }
            DispatchQueue.main.asyncAfter(deadline: .now()+value.duration) {
                item = nil
            }
        })
        
        .padding(10)
        .frame(height: 90, alignment: .topLeading)
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemGroupedBackground).ignoresSafeArea())
        .cornerRadius(12)
        .padding(.horizontal, 10)
        .opacity(item != nil ? 1 : 0)
        .offset(y: item != nil ? 0 : -100-(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .transition(.move(edge: .top))
        .animation(.spring())
    }
}
