//
//  RemindersService.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause  I'm Electric on 3/7/24.
//

import Foundation
import CoreData
import UIKit

class RemindersService {
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }
    
    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
}