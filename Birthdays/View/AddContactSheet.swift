//
//  AddContactSheet.swift
//  Birthdays
//
//  Created by Ruslan Alekyan on 01.03.2025.
//

import PhotosUI
import SwiftUI

struct AddContactSheet: View {
    @EnvironmentObject private var viewModel: BirthdaysViewModel
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    
    @State private var name = ""
    @State private var surname = ""
    @State private var birthday = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        PhotosPicker(selection: $selectedPhoto, matching: .images) {
                            Group {
                                if let imageData = selectedPhotoData, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(.circle)
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .foregroundStyle(.gray)
                                }
                            }
                            .frame(width: 150, height: 150)
                        }
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                .listSectionSpacing(0)
                
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
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                selectedPhotoData = data
            }
        }
    }
    
    private func addContact() {
        let contact = Contact(name: name, surname: surname, birthday: birthday, imageData: selectedPhotoData)
        modelContext.insert(contact)
        viewModel.addNotification(for: contact)
        dismiss()
    }
}

#Preview {
    AddContactSheet()
        .environmentObject(BirthdaysViewModel())
}
