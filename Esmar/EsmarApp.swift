//
//  EsmarApp.swift
//  Esmar
//
//  Created by Rafael Nunes on 26/02/25.
//

import SwiftUI

@main
struct EsmarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
