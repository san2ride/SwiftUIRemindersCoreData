//
//  RemindersSwiftUICoreDataApp.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause  I'm Electric on 3/6/24.
//

import SwiftUI
import UserNotifications

@main
struct RemindersSwiftUICoreDataApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                // notification is granted
            } else {
                // display message to the user
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            RemindersView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
