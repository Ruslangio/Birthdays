//
//  ContactRow.swift
//  Birthdays
//
//  Created by Ruslan Alekyan on 05.03.2025.
//

import SwiftUI

struct ContactRow: View {
    let contact: Contact
    
    var body: some View {
        HStack {
            Group {
                if let imageData = contact.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                } else {
                    Text(contact.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            }
            .frame(width: 60, height: 60)
            .background(.tertiary)
            .clipShape(.circle)
            
            VStack(alignment: .leading) {
                Text(contact.fullname)
                    .font(.headline)
                Text(contact.birthday, style: .date)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if contact.daysUntilBirthday == 0 {
                Image(systemName: "gift.fill")
                    .foregroundStyle(.blue)
                    .font(.title2)
            } else {
                VStack {
                    Text(contact.daysUntilBirthday, format: .number)
                        .font(.headline)
                    Text("days.remaining (\(contact.daysUntilBirthday))")
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    List {
        ContactRow(contact: Contact(name: "Ruslan", surname: "Alekyan", birthday: Date()))
        ContactRow(contact: Contact(name: "Andrey", surname: "Zebelyan", birthday: Calendar.current.date(from: DateComponents(year: 1999, month: 9, day: 30))!))
    }
}
