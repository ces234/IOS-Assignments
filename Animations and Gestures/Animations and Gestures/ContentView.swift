//
//  ContentView.swift
//  Animations and Gestures
//
//  Created by Caroline Schafer on 3/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Spacer()
            Text("Quizzo")
                .font(.title)
                .padding()
            Text("Are you ready to test your knowledge?")
                .padding()
            
            Button("Begin"){
                
            }
            .padding()
            .frame(width: 100, height: 40)
            .background(Color.blue)  // Background color
            .foregroundColor(.white) // Text color
            .cornerRadius(10)        // Rounded corners
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
