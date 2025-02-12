//
//  Contact.swift
//  SpartieMessagesWithNavigation
//
//  Created by Zoe Goldberg on 2/11/25.
//

import Foundation

struct Contact : Identifiable {
    let id:UUID = UUID()
    var firstName:String
    var lastName:String
    var isFavorite:Bool
    var picture:String
    var messages:[Message]
}
