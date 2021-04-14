//
//  LatestApp.swift
//  Latest
//
//  Created by Cédric Bahirwe on 14/04/2021.
//

import SwiftUI

@main
struct LatestApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var appManager = AppManagerViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
