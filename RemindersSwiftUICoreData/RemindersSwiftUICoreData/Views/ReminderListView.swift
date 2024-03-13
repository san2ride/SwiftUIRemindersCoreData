//
//  ReminderListView.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/11/24.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                    case .onSelect(let reminder):
                        print("onSelect")
                    case .onCheckedChange(let reminder):
                        print("onCheckedChange")
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
