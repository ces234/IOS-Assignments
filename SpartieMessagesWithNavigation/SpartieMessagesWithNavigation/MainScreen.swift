//
//  MainScreen.swift
//  SpartieMessagesWithNavigation
//
//  Created by Zoe Goldberg on 2/11/25.
//

import SwiftUI

struct MainScreen: View {
    @State var contacts = [Contact]()
    @State var contact = Contact(firstName: "", lastName: "", isFavorite: false, picture: "", messages: [])
    @State private var showing = false
    
    var body: some View {
        NavigationStack {
            
            VStack {
            
                List {
                    ForEach($contacts) { $currContact in
                        NavigationLink {
                            MessagePageView(contact: $currContact, contacts: $contacts)
                        }
                        label: {
                            ContactRow(contact: currContact)
                        }

                    }

                }                                            .listStyle(.plain)
                    .padding(.top, 15)
                    .background(Color(UIColor(named: "BackgroundColor")!))



            
               
            }
            .navigationTitle("Contacts")
            .sheet(isPresented: $showing) {
                ProfileView(contact: $contact, contacts: $contacts, isUpdating: false)

                
            }
            .background(Color(UIColor(named: "BackgroundColor")!))
            .toolbar() {
                Button(action:  {
                    showing.toggle()
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            }
            
        }
        
        .padding()
        .background(Color(UIColor(named: "BackgroundColor")!))

        
    }
}

#Preview {
    @Previewable @State var contacts = [
        Contact(firstName: "D'Andre", lastName: "Swift", isFavorite: true, picture: "DAndreSwift", messages: [Message(message: "Hello D'Andre")]),
        Contact(firstName: "Taylor", lastName: "Swift", isFavorite: true, picture: "TaylorSwift", messages: [Message(message: "I am a SWIFTie")]),
        Contact(firstName: "Jeremy", lastName: "Swift", isFavorite: false, picture: "JeremySwift", messages: [Message(message: "Hello Jeremy")])
    ]
    
    MainScreen(contacts:contacts)
}
