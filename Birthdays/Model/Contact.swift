//
//  Contact.swift
//  Birthdays
//
//  Created by Ruslan Alekyan on 01.03.2025.
//

import Foundation
import SwiftData

@Model
final class Contact: Identifiable {
    var id = UUID()
    var name: String
    var surname: String
    var birthday: Date
    @Attribute(.externalStorage) var imageData: Data?
    
    var fullname: String {
        name + " " + surname
    }
    
    var initials: String {
        fullname.components(separatedBy: " ").reduce("") { $0 + $1.prefix(1) }
    }
    
    var daysUntilBirthday: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let birthdayDate = calendar.startOfDay(for: birthday)
        
        let todayComponents = calendar.dateComponents([.month, .day], from: today)
        let birthdayComponents = calendar.dateComponents([.month, .day], from: birthday)
        
        if todayComponents == birthdayComponents {
            return 0
        }
        
        guard let nextBirthday = calendar.nextDate(
            after: today,
            matching: calendar.dateComponents([.month, .day], from: birthdayDate),
            matchingPolicy: .nextTimePreservingSmallerComponents
        ) else {
            return 0
        }

        return calendar.dateComponents([.day], from: today, to: nextBirthday).day ?? 0
    }
    
    init(name: String, surname: String, birthday: Date, imageData: Data? = nil) {
        self.name = name
        self.surname = surname
        self.birthday = birthday
        self.imageData = imageData
    }
}
