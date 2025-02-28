//
//  ContactRow.swift
//  SpartieMessagesWithNavigation
//
//  Created by Zoe Goldberg on 2/11/25.
//

import SwiftUI

struct ContactRow: View {
    let contact:Contact
    
    var body: some View {
        HStack {
            if contact.picture != "" {
                Image(contact.picture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
                    .padding(.trailing, 10)
            }
            else {
                Image("DefaultContact")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
                    .padding(.trailing, 10)
            }
            
            
            VStack(alignment: .leading) {
                Spacer()
                Text(contact.firstName).font(.title2)
                
                    
                Text(contact.lastName)
                    .foregroundStyle(Color.gray)
                    .font(.title3)
                Spacer()
            }
            Spacer()
            VStack {
                if(contact.isFavorite) {
                    Image(systemName: "star.fill")
                        .imageScale(.large)
                        .padding(.trailing, 10)
                        .foregroundStyle(Color(UIColor(named: "DarkPink")!))
                }
            }
        }

//        .padding()
    }
}

#Preview {
    ContactRow(contact: Contact(firstName: "Zoe", lastName: "Goldberg", isFavorite: true, picture: "", messages: []))
}
