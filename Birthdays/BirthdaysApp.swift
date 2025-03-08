//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Ruslan Alekyan on 01.03.2025.
//

import SwiftData
import SwiftUI

@main
struct BirthdaysApp: App {
    @StateObject private var viewModel = BirthdaysViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContactListView()
                .environmentObject(viewModel)
        }
        .modelContainer(for: Contact.self)
    }
}
