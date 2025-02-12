//
//  ProfileView.swift
//  SpartieMessagesWithNavigation
//
//  Created by Amala on 2/11/25.
//

import SwiftUI

struct Contact {
    var firstName:String
    var lastName:String
    var picture:String
    var isFavorite:Bool
}

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var contact:Contact
    @Binding var contacts:[Contact]
    
    var isUpdating:Bool
    
    var body: some View {
        
        VStack {
            
            if contact.picture != "" {
                Image(contact.picture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
            }
            else {
                Image("DefaultContact")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
            }
            
            VStack {
                TextField("First Name", text:$contact.firstName)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                TextField("Last Name", text:$contact.lastName)
                    .font(.largeTitle)
                    .fontWeight(.light)
                
                Toggle(isOn: $contact.isFavorite) {
                    Text("Is Favorite")
                        .font(.title3)
                }
                .padding(.top, 30)
            }
            .padding()
            
            Spacer()
            
            if !isUpdating {
                Button("Save New Contact") {
                    contacts.append(contact)
                    
                    contact = Contact(firstName: "", lastName: "", picture: "", isFavorite: false)
                    dismiss()
                }
            }
        }
        .padding()
        .navigationTitle(isUpdating ? "Update Contact" : "Create Contact")
    }
}


#Preview {
    @Previewable @State var contact: Contact = Contact(firstName: "Brian", lastName: "Krupp", picture: "", isFavorite: true)
    @Previewable @State var contacts: [Contact] = []
    
    
    ProfileView(contact: $contact, contacts: $contacts, isUpdating: false)
    
}
