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
    var categoryPlayCounts: [String: Int] = [:]
    var recentCategories: [String] = []
    var lastPlayedDate: Date? = nil

    init(firstName: String, lastName: String, username: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
    }
}

extension User {
    var topCategories: [String] {
        categoryPlayCounts
            .sorted { $0.value > $1.value }
            .prefix(3)
            .map { $0.key }
    }
}


