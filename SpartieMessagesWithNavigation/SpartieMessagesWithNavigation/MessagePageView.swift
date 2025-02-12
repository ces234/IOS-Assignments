//
//  MessagePageView.swift
//  SpartieMessagesWithNavigation
//
//  Created by Zoe Goldberg on 2/11/25.
//

import SwiftUI

struct MessagePageView: View {
    @State private var currentMessage = ""
    @Binding var contact:Contact
    @Binding var contacts:[Contact]
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    ProfileView(contact: $contact, contacts: $contacts, isUpdating: true)
                } label: {
                    ContactRow(contact: contact)
                }
                
                Spacer()
                
                
                List {
                    ForEach(contact.messages) { msg in
                        MessageView(message: msg)
                        
                    }
                    .listRowSeparator(.hidden)
                    
                }.listStyle(.inset)
                
                HStack {
                    TextField("Type Message...", text:$currentMessage)
                    Button(action: {
                        contact.messages.append(Message(message: currentMessage))
                        currentMessage = ""
                    }) {
                        Image(systemName: "arrow.up.heart")
                            .foregroundColor(Color(UIColor(named: "DarkPink")!))
                            .imageScale(.large)
                    }
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    @Previewable @State var contact = Contact(firstName: "Zoe", lastName: "Goldberg", isFavorite: true, picture: "", messages: [Message(message: "hello")])
    
    @Previewable @State var contacts = [Contact]()
    
    MessagePageView(contact: $contact, contacts: $contacts)
}
