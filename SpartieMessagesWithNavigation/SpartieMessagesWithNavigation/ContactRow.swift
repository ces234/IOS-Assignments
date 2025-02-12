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
//            Image(systemName: "contact.photo")
//                .imageScale(.large)
//            if let photo = contact.photo, !photo.isEmpty {
//                Image(photo)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 50, height: 50)
//                    .clipShape(Circle())
//            } else {
////              ADD IMAGE IN ASSETS
//                Image(systemName: "person.crop.circle.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 50, height: 50)
//                    .foregroundColor(.gray)
//            }
            
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
                }
            }
        }.padding()
    }
}

#Preview {
    ContactRow(contact: Contact(firstName: "Zoe", lastName: "Goldberg", isFavorite: true, photo: ""))
}
