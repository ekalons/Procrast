//
//  Habit.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/19/21.
//

import UIKit
import RealmSwift

class Habit: Object {
    
    @objc dynamic var _id: ObjectId = ObjectId.generate()
    @objc dynamic var title: String = ""
    @objc dynamic var color: String = ""
    @objc dynamic var isCompleted: Bool = false
    @objc dynamic var avoidWeekends: Bool = false
    @objc dynamic var creationDate: Date?
    @objc dynamic var reminderDate: Date?
    @objc dynamic var streakCounter: Int = 0
    
    
    convenience init( _id: String, title: String, color: String, isCompleted: Bool, avoidWeekends: Bool, creationDate: Date?, reminderDate: Date?, streakCounter: Int) {
        self.init()
        self.title = title
        self.color = color
        self.isCompleted = isCompleted
//        self.completedForDay = completedForDay
        self.avoidWeekends = avoidWeekends
        self.creationDate = creationDate
        self.reminderDate = reminderDate
        self.streakCounter = streakCounter
    }
    override static func primaryKey() -> String? {
        return "_id"
    }


//    @objc dynamic var firstHabitCompleted: Bool = false
}

extension Habit {
    
    func toggleCompleted() {
        
      guard let realm = realm else { return }
      try! realm.write {
        isCompleted = !isCompleted
        
      }
    }
}
