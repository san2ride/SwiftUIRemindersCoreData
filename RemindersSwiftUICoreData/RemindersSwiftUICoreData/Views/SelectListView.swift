//
//  SelectListView.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/12/24.
//

import SwiftUI

struct SelectListView: View {
    @FetchRequest(sortDescriptors: [])
    private var myListsFetchResults: FetchedResults<MyList>
    @Binding var selectedList: MyList?
    
    var body: some View {
        List(myListsFetchResults) { myList in
            HStack {
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundColor(Color(myList.color))
                    Text(myList.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedList = myList
                }
                if selectedList == myList {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    SelectListView(selectedList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
