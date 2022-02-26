//
//  Tap_to_countApp.swift
//  Shared
//
//  Created by Michal Jan Warecki on 26/02/2022.
//

import SwiftUI

@main
struct Tap_to_countApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
