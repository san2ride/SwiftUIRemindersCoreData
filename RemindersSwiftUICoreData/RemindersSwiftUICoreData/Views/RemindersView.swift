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
    
    @State private var search: String = ""
    @State private var isPresented: Bool = false
    @State private var searching: Bool = false
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        ReminderStatsView(icon: "calendar", title: "Today", count: 9)
                        ReminderStatsView(icon: "tray.circle.fill", title: "All", count: 4)
                    }
                    HStack {
                        ReminderStatsView(icon: "calendar", title: "Today", count: 9)
                        ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: 14)
                    }
                    MyListView(myLists: myListResults)
                    
                    //Spacer()
                    
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
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
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
