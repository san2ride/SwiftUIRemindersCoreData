//
//  MyListView.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/7/24.
//

import SwiftUI

struct MyListView: View {
    let myLists: FetchedResults<MyList>
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                Text("No reminders found")
            } else {
                ForEach(myLists) { myList in
                    NavigationLink(value: myList) {
                        VStack {
                            MyListCellView(myList: myList)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading], 10)
                                .font(.title3)
                            Divider()
                        }
                    }.listRowBackground(colorScheme == .dark ? Color.darkGray: Color.offWhite)
                }.scrollContentBackground(.hidden)
                    .navigationDestination(for: MyList.self) { myList in
                        MyListDetailView(myList: myList)
                            .navigationTitle(myList.name)
                    }
                }
        }
    }
}

/*
#Preview {
    /MyListView(myLists: PreviewData.myList)
}
*/

