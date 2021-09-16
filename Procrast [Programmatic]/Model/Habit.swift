//The MIT License (MIT)
//
//Copyright (c) 2021 Ekaitz Alonso Larrea
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
    @Persisted var reminderDate: String? = nil
    @Persisted var streakCounter: Int = 0
    @Persisted var streakList: List<Date?>
    @Persisted var archived: Bool = false   // For future updates

    
    
    convenience init(title: String, color: String, avoidWeekends: Bool, reminderDate: String?) {
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
