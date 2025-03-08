//
//  AddContactSheet.swift
//  Birthdays
//
//  Created by Ruslan Alekyan on 01.03.2025.
//

import SwiftUI

struct AddContactSheet: View {
    @EnvironmentObject private var viewModel: BirthdaysViewModel
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name = ""
    @State private var surname = ""
    @State private var birthday = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("section.fullName") {
                    TextField("field.contact.name", text: $name)
                    TextField("field.contact.surname", text: $surname)
                }
                .autocorrectionDisabled()
                
                Section("section.birthday") {
                    DatePicker("field.contact.birthday", selection: $birthday, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }
            }
            .navigationTitle("navigation.newContact.title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("button.cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("button.add", action: addContact)
                        .disabled(name.isEmpty || surname.isEmpty)
                }
            }
        }
    }
    
    private func addContact() {
        let contact = Contact(name: name, surname: surname, birthday: birthday)
        modelContext.insert(contact)
        viewModel.addNotification(for: contact)
        dismiss()
    }
}

#Preview {
    AddContactSheet()
        .environmentObject(BirthdaysViewModel())
}
