//
//  SessionManager.swift
//  SmartiePants
//
//  Created by Amala on 4/21/25.
//

import Foundation
import SwiftData

@MainActor
final class SessionManager: ObservableObject {
    @Published var currentUser: User? = nil
    
    func logout() {
        currentUser = nil
    }
}
