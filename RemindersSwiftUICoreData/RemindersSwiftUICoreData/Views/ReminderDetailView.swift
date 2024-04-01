//
//  ReminderDetailView.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/12/24.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var reminder: Reminder
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
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
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.cyan)
                        }
                        if editConfig.hasTime {
                            DatePicker("Select Date", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        Section {
                            NavigationLink {
                                SelectListView(selectedList: $reminder.list)
                            } label: {
                                HStack {
                                    Text("List")
                                    Spacer()
                                    Text(reminder.list!.name)
                                }
                            }
                        }
                    }.onChange(of: editConfig.hasDate) { hasDate in
                        if hasDate {
                            editConfig.reminderDate = Date()
                        }
                    }.onChange(of: editConfig.hasTime) { hasTime in
                        if hasTime {
                            editConfig.reminderTime = Date()
                        }
                    }
                }.listStyle(.insetGrouped)
            }.onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                        .font(.largeTitle)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                            do {
                                let updated = try RemindersService.updateReminder(reminder: reminder,
                                                                                  editConfig: editConfig)
                                if updated {
                                    // check if we should even schedule a notification
                                    if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                        let userData = UserData(title: reminder.title,
                                                                body: reminder.notes,
                                                                date: reminder.reminderDate,
                                                                time: reminder.reminderTime)
                                        NotificationManager.scheduleNotification(userData: userData)
                                    }
                                }
                            } catch {
                                print(error)
                            }
                        dismiss()
                    }.disabled(!isFormValid)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
