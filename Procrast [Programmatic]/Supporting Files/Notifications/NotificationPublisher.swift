//
//  NotificationPublisher.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz Alonso on 9/19/21.
//

import Foundation
import UserNotifications
import RealmSwift

class NotificationPublisher {
    
    var uuidToSave: String = ""
    
    func requestNotificationsPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        }
    }

    func configuringNotifications(habitTitle: String, time: String) {       //  --> To set time as trigger time & habitTitle & content.title
        // Creating the content
        let content = UNMutableNotificationContent()
        content.title = habitTitle
        
        // Creating the trigger time
        var dateComponents = DateComponents()
        dateComponents.hour = Int(time.dropLast(3))
        dateComponents.minute = Int(time.dropFirst(3))
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Creating the request
        let uuid = UUID().uuidString
        uuidToSave = uuid
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        // Registering the request
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            // Check error paramenter for errors
        }
        
         
    }
}


