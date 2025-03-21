//
//  ContactListView.swift
//  Birthdays
//
//  Created by Ruslan Alekyan on 01.03.2025.
//

import SwiftData
import SwiftUI

struct ContactListView: View {
    @EnvironmentObject private var viewModel: BirthdaysViewModel
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Contact.birthday) private var contacts: [Contact]
    
    @State private var isShowingAddContactSheet = false
    
    var body: some View {
        NavigationStack {
            Group {
                if contacts.isEmpty {
                    ContentUnavailableView {
                        Label("label.noContacts", systemImage: "person.crop.circle.fill")
                    } description: {
                        Text("text.contacts.emptyDescription")
                    } actions: {
                        Button("button.createNewContact") {
                            isShowingAddContactSheet.toggle()
                        }
                    }
                } else {
                    List {
                        ForEach(contacts) { contact in
                            ContactRow(contact: contact)
                        }
                        .onDelete(perform: deleteContacts)
                    }
                }
            }
            .navigationTitle("app.name")
            .toolbar {
                ToolbarItem {
                    Button {
                        isShowingAddContactSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddContactSheet) {
                AddContactSheet()
                    .interactiveDismissDisabled()
            }
        }
    }
    
    private func deleteContacts(at offsets: IndexSet) {
        for index in offsets {
            let contact = contacts[index]
            viewModel.cancelNotification(for: contact)
            modelContext.delete(contact)
        }
    }
}

#Preview(traits: .sampleData) {
    ContactListView()
        .environmentObject(BirthdaysViewModel())
}
