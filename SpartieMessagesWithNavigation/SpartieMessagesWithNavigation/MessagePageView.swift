//
//  MessagePageView.swift
//  SpartieMessagesWithNavigation
//
//  Created by Zoe Goldberg on 2/11/25.
//

import SwiftUI

struct MessagePageView: View {
    @State private var currentMessage = ""
    @Binding var contact: Contact
    @Binding var contacts: [Contact]

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    ProfileView(contact: $contact, contacts: $contacts, isUpdating: true)
                } label: {
                    ContactRow(contact: contact)
                        .frame(height: 80)
                }

                Spacer()

                List {
                    ForEach(contact.messages) { msg in
                        MessageView(message: msg)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear) // Removes white background behind rows
                            .background(Color(UIColor(named: "BackgroundColor")!)) // Ensures full background match
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden) // Removes default List background
                .background(Color(UIColor(named: "BackgroundColor")!)) // Sets background color for the entire List

                HStack {
                    TextField("Type Message...", text: $currentMessage)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        contact.messages.append(Message(message: currentMessage))
                        currentMessage = ""
                    }) {
                        Image(systemName: "arrow.up.heart")
                            .foregroundColor(Color(UIColor(named: "DarkPink")!))
                            .imageScale(.large)
                    }
                }
                .padding()
            }
            .padding()
            .background(Color(UIColor(named: "BackgroundColor")!)) // Ensures background color for the entire screen
        }
    }
}



#Preview {
    @Previewable @State var contact = Contact(firstName: "Zoe", lastName: "Goldberg", isFavorite: true, picture: "", messages: [Message(message: "hello")])
    
    @Previewable @State var contacts = [Contact]()
    
    MessagePageView(contact: $contact, contacts: $contacts)
}
