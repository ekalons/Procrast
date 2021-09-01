//
//  Habit.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/19/21.
//

import UIKit
import RealmSwift

class Habit: Object {
    
    @Persisted var _id: ObjectId = ObjectId.generate()
    @Persisted var _partition: String? = "4446667777"
    @Persisted var title: String = ""
    @Persisted var color: String = ""
    @Persisted var isCompleted: Bool = false
    @Persisted var avoidWeekends: Bool = false
    @Persisted var creationDate: Date = Date()
    @Persisted var reminderDate: Date? = nil
    @Persisted var streakCounter: Int = 0
    @Persisted var streakList: List<Date?>

    
    
    convenience init(title: String, color: String, avoidWeekends: Bool, reminderDate: Date?) {
        self.init()
        self.title = title
        self.color = color
        self.avoidWeekends = avoidWeekends
        self.reminderDate = reminderDate
    }
    override static func primaryKey() -> String? {
        return "_id"
    }


//    @Persisted var firstHabitCompleted: Bool = false
}

extension Habit {
    
    func toggleCompleted() {
        guard let realm = realm else { return }
        
        try! realm.write {
            isCompleted = !isCompleted
        }
    }
    
    func appendToStreak() {
        guard let realm = realm else { return }
        
        try! realm.write {
            if streakList.last != Date().onlyDate {
                streakList.append(Date().onlyDate)
                streakCounter = streakList.count
            }
            
        }
    }
    
    func popFromStreak() {
        guard let realm = realm else { return }
        
        try! realm.write {
            if streakList.last == Date().onlyDate {
                streakList.removeLast()
                streakCounter = streakList.count
            }
            
        }
    }
}
