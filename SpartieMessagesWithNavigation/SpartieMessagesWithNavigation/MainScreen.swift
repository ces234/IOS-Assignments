//
//  MainScreen.swift
//  SpartieMessagesWithNavigation
//
//  Created by Zoe Goldberg on 2/11/25.
//

import SwiftUI

struct MainScreen: View {
    @State var contacts = [Contact]()
    
    var body: some View {
        VStack {
            HStack {
                Text("Contacts")
                    .font(.largeTitle).bold()
                Spacer()
                Button(action:  {
                    print("add contact")
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            }.padding()
            
            List {
                ForEach($contacts) { $currContact in
                    // ADD A NAVIGATION LINK TO THE MESSAGES OF PERSON
                    ContactRow(contact: currContact)
                    
                }
            }.listStyle(.plain)
           
           

        }
        .padding()
    }
}

#Preview {
    @Previewable @State var contacts = [
        Contact(firstName: "D'Andre", lastName: "Swift", isFavorite: true, photo: ""),
        Contact(firstName: "Taylor", lastName: "Swift", isFavorite: true, photo: ""),
        Contact(firstName: "Jeremy", lastName: "Swift", isFavorite: false, photo: "")]
    
    MainScreen(contacts:contacts)
}
