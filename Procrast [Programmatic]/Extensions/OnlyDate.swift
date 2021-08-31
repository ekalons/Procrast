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
            let calendar = Calendar.current
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calendar.date(from: dateComponents)
        }
    }

}
