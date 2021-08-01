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
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) {
            switch $0 {
            case .active:
                print("Come to foreground")
            case .background:
                print("Went to background")
            case .inactive:
                print("Become inactive")
            @unknown default:
                print("Unknown Phase")
            }
        }
    }
}
