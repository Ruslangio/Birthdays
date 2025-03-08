//
//  NotificationManager.swift
//  Birthdays
//
//  Created by Ruslan Alekyan on 02.03.2025.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() async {
        do {
            try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addNotification(for contact: Contact) {
        let content = UNMutableNotificationContent()
        content.title = "\(contact.fullname)"
        content.body = "has a birthday today"
        content.sound = .default
        content.badge = 1
        
        var date = Calendar.current.dateComponents([.month, .day], from: contact.birthday)
        date.hour = 10
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: contact.id.uuidString, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
    
    func cancelNotification(for contact: Contact) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [contact.id.uuidString])
    }
    
    func resetBadgeCount() async {
        do {
            try await notificationCenter.setBadgeCount(0)
        } catch {
            print(error.localizedDescription)
        }
    }
}
