//
//  RemindersSwiftUICoreDataApp.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause  I'm Electric on 3/6/24.
//

import SwiftUI

@main
struct RemindersSwiftUICoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            RemindersView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
