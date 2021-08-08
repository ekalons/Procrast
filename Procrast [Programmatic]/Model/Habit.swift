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
//    @objc dynamic var color: UIColor
    @objc dynamic var isCompleted: Bool = false
//    @objc dynamic var completedForDay: Bool = false
    @objc dynamic var avoidWeekends: Bool = false
//    @objc dynamic var creationDate: Date?
    
    
    convenience init( _id: String, title: String, isCompleted: Bool, avoidWeekends: Bool) {
        self.init()
        self.title = title
//        self.color =  color
        self.isCompleted = isCompleted
//        self.completedForDay = completedForDay
        self.avoidWeekends = avoidWeekends
//        self.creationDate = creationDate
    }
    override static func primaryKey() -> String? {
        return "_id"
    }


//    @objc dynamic var firstHabitCompleted: Bool = false
//    @objc dynamic var creationDate: Date?
}

//struct Habit {
//    var color: UIColor
//    var title: String = ""
//    var completeness: Bool = false
//
//}
