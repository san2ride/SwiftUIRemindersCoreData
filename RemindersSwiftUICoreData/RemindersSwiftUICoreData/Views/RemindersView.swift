//
//  RemindersView.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause  I'm Electric on 3/6/24.
//

import SwiftUI

struct RemindersView: View {
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hi Hi World")
                
                Spacer()
                
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
            }.sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        // save the list to the database
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    RemindersView()
}
