//
//  StudyCardsApp.swift
//  StudyCards
//
//  Created by Hurriya Ali on 12/12/23.
//

import SwiftUI

@main
struct StudyCardsApp : App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
