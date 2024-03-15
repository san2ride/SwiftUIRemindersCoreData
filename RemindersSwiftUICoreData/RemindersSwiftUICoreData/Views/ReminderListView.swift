//
//  ReminderListView.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/11/24.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    private func reminderCheckedChanged(reminder: Reminder) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = !reminder.isCompleted
        
        do {
            let _ = try RemindersService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                    case .onSelect(let reminder):
                        print("onSelect")
                    case .onCheckedChange(let reminder):
                        reminderCheckedChanged(reminder: reminder)
                    case .onInfo:
                        print("onInfo")
                }
            }
        }
    }
}

/*
#Preview {
    ReminderListView()
}
*/
