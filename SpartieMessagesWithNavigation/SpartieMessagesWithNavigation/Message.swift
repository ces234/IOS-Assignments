//
//  Message.swift
//  SpartieMessagesWithNavigation
//
//  Created by Zoe Goldberg on 2/11/25.
//
import Foundation

struct Message : Identifiable {
    let message:String
    let date:Date
    let id:UUID
    
    init(message: String) {
        self.message = message
        self.date = Date()
        self.id = UUID()
    }
}
