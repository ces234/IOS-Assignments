//
//  ResultsPage.swift
//  Animations and Gestures
//
//  Created by Caroline Schafer on 3/25/25.
//

import SwiftUI

struct ResultsPage: View {
    let incorrectCount: Int
    let onRestart: () -> Void
    
    var body: some View {
        VStack {
            Text("Quiz Results")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("You selected a wrong answer \(incorrectCount) times.")
                .padding()
            
            if (incorrectCount >= 8) {
                Text("Yikes!")
            }
            else if (incorrectCount >= 6) {
                Text("Uh Oh!")
            }
            else if (incorrectCount >= 4) {
                Text("You can do better than that!")
            }
            else if (incorrectCount >= 1) {
                Text("Not too shabby!")
            }
            else if (incorrectCount == 0) {
                Text("Way to go! You got them all right! 🎉")
            }
            
            
            Button("Try Again") {
                onRestart()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
    }
}

#Preview {
    ResultsPage(incorrectCount: 5, onRestart: {})
}
