//
//  UserModel.swift
//  SmartiePants
//
//  Created by Amala on 4/14/25.
//

import Foundation
import SwiftData

@Model
final class User {

    var id: UUID = UUID()
    var firstName: String
    var lastName: String
    var username: String
    var password: String
    var dailyPoints: Int = 0
    var dailyStreak: Int = 0

    init(firstName: String, lastName: String, username: String, password: String, dailyPoints: Int = 0, dailyStreak: Int = 0) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
    }
}

