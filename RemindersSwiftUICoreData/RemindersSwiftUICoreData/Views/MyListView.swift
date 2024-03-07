//
//  MyListView.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/7/24.
//

import SwiftUI

struct MyListView: View {
    let myLists: FetchedResults<MyList>
    
    var body: some View {
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                Text("No reminders found")
            } else {
                ForEach(myLists) { myLists in
                    Text(myLists.name)
                }
            }
        }
    }
}

//#Preview {
//    MyListView()
//}
