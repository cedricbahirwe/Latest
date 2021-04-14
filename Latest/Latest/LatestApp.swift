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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
