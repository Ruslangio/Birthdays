//
//  SampleData.swift
//  Birthdays
//
//  Created by Ruslan Alekyan on 02.03.2025.
//

import SwiftData
import SwiftUI

struct SampleData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let container = try ModelContainer(for: Contact.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        container.mainContext.insert(Contact(name: "Андрей", surname: "Зебелян", birthday: Calendar.current.date(from: DateComponents(year: 1999, month: 9, day: 30))!))
        container.mainContext.insert(Contact(name: "Арсен", surname: "Геворгян", birthday: Calendar.current.date(from: DateComponents(year: 1999, month: 12, day: 29))!))
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleData: Self = .modifier(SampleData())
}
