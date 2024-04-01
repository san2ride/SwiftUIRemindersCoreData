//
//  RemindersView.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause  I'm Electric on 3/6/24.
//

import SwiftUI

struct RemindersView: View {
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: RemindersService.remindersByStatType(statType: .today))
    private var todayResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: RemindersService.remindersByStatType(statType: .scheduled))
    private var scheduledResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: RemindersService.remindersByStatType(statType: .all))
    private var allResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: RemindersService.remindersByStatType(statType: .completed))
    private var completedResults: FetchedResults<Reminder>
    
    @State private var search: String = ""
    @State private var isPresented: Bool = false
    @State private var searching: Bool = false
    
    private var remindersStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValues()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: todayResults)
                        } label: {
                            ReminderStatsView(icon: "calendar",
                                              title: "Today",
                                              count: reminderStatsValues.todayCount)
                        }
                        NavigationLink {
                            ReminderListView(reminders: scheduledResults)
                        } label: {
                            Remis
                            ReminderStatsView(icon: "calendar.circle.fill",
                                              title: "Scheduled",
                                              count: reminderStatsValues.scheduledCount)
                        }
                    }
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: allResults)
                        } label: {
                            ReminderStatsView(icon: "tray.circle.fill",
                                              title: "All",
                                              count: reminderStatsValues.allCount)
                        }
                        NavigationLink {
                            ReminderListView(reminders: completedResults)
                        } label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", 
                                              title: "Completed",
                                              count: reminderStatsValues.completedCount)
                        }
                    }
                    Text("My Lists")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    MyListView(myLists: myListResults)
                                        
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }.padding()
                }
            }.sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        // save the list to the database
                        do {
                            try RemindersService.saveMyList(name, color)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }.listStyle(.plain)
            .onChange(of: search, perform: { searchTerm in
                searching = !searchTerm.isEmpty ? true : false
                searchResults.nsPredicate = RemindersService.getRemindersBySearchTerm(search).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResults)
                    .opacity(searching ? 1.0 : 0.0)
            })
            .onAppear {
                reminderStatsValues = remindersStatsBuilder.build(myListResults: myListResults)
            }
            .padding()
            .navigationTitle("Reminders")
        }.searchable(text: $search)
    }
}

#Preview {
    RemindersView()
        .environment(\.managedObjectContext,
                      CoreDataProvider.shared.persistentContainer.viewContext)
}
