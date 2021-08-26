//
//  OnlyDate.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz Alonso on 8/26/21.
//

import Foundation

extension Date {

    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calender.date(from: dateComponents)
        }
    }

}
