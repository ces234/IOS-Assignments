//
//  ContentView.swift
//  Animations and Gestures
//
//  Created by Caroline Schafer on 3/11/25.
//

import SwiftUI

struct ContentView: View {
    @State var showQuiz = false
    
    var body: some View {
        NavigationStack {
            Spacer()
            Text("Quizzo")
                .font(.title)
                .padding()
            
            if !showQuiz {
                Text("Are you ready to test your knowledge?")
                    .padding()
                
                Button("Begin"){
                    withAnimation(.easeIn(duration: 0.25)){
                        showQuiz = true
                    }
                    
                }
                .padding()
                .frame(width: 100, height: 40)
                .background(Color.blue)  // Background color
                .foregroundColor(.white) // Text color
                .cornerRadius(10)
                Spacer()
            }
                     
            if showQuiz {
                QuestionPage()
            }
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
