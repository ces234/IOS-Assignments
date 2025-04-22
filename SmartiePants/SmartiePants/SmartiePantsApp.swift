//
//  SmartiePantsApp.swift
//  SmartiePants
//
//  Created by Caroline Schafer on 3/6/25.
//
import SwiftUI
import SwiftData

@main
struct SmartiePantsApp: App {
    @StateObject private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
//                .environment(\.font, Font.custom("Poppins-Regular", size: 14))
        }
        .modelContainer(for: User.self)
    }
}

