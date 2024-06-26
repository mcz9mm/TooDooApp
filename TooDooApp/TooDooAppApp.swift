//
//  TooDooAppApp.swift
//  TooDooApp
//
//  Created by kaoru matarai on 2024/05/17.
//

import SwiftUI
import SwiftData

@main
struct TooDooAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

  var body: some Scene {
    WindowGroup {
      TopPage()
    }
    .modelContainer(sharedModelContainer)
  }
}
