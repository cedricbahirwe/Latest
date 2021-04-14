//
//  ContentView.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/,
                content:  {
                    HomeView()
                        .tabItem {
                            Image(systemName: "newspaper.fill")
                            
                        }.tag(1)
                    ConfigurationsView()
                        .tabItem {
                            Image(systemName: "star.square.fill")
                            
                        }.tag(2)
                })
            .accentColor(.mainColor)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
