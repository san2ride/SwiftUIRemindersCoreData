//
//  NotificationManager.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/31/24.
//

import Foundation
import UserNotifications

struct UserData {
    let title: String?
    let body: String?
    let date: Date?
    let time: Date?
}

class NotificationManager {
    static func scheduleNotification(userData: UserData) {
        let content = UNMutableNotificationContent()
        content.title = userData.title ?? ""
        content.body = userData.body ?? "" // body are notes in Reminder
        
        // date components
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: userData.date ?? Date())
        
        if let reminderTime = userData.time {
            let reminderTimeDateComponents = reminderTime.dateComponents
            dateComponents.hour = reminderTimeDateComponents.hour
            dateComponents.minute = reminderTimeDateComponents.minute
        }
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Don't Forget!",
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
