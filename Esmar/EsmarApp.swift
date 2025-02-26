//
//  EsmarApp.swift
//  Esmar
//
//  Created by Rafael Nunes on 26/02/25.
//

import SwiftUI

@main
struct EsmarApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
