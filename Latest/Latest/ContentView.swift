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
        TabView(selection: .constant(1)) {
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
        .sheet(isPresented: $data.showProfileView) {
            ProfileView()
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
