//
//  MyList+CoreDataClass.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/6/24.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { ($0 as! Reminder) } ?? []
    }
}
