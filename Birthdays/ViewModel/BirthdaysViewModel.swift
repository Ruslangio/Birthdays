//
//  BirthdaysViewModel.swift
//  Birthdays
//
//  Created by Ruslan Alekyan on 03.03.2025.
//

import Foundation

final class BirthdaysViewModel: ObservableObject {

    init() {
        Task {
            await notificationManager.requestAuthorization()
            await notificationManager.resetBadgeCount()
        }
    }
    
    private let notificationManager = NotificationManager.shared
    
    func addNotification(for contact: Contact) {
        notificationManager.addNotification(for: contact)
    }
    
    func cancelNotification(for contact: Contact) {
        notificationManager.cancelNotification(for: contact)
    }
}
