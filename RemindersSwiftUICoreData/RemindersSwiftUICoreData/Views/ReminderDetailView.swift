//
//  ReminderDetailView.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/12/24.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Binding var reminder: Reminder
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }
                    }
                }
            }.onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
