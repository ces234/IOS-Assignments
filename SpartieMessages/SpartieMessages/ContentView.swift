//
//  ContentView.swift
//  Assignment1
//
//  Created by Zoe Goldberg, Amala Penumaka, Caroline Schafer
//

import SwiftUI

struct ContentView: View {
    @State var currentMessage = ""
    @State var allMessages = [Message]()


    
    var body: some View {
        VStack {
            List {
                ForEach(allMessages) { msg in
                    MessageView(message: msg)
                    
                }
                .listRowSeparator(.hidden)

            }.listStyle(.inset)
            
            HStack {
                TextField("Type Message...", text:$currentMessage)
                Button(action: {
                    allMessages.append(Message(message: currentMessage))
                    currentMessage = ""
                }) {
                    Image(systemName: "arrow.up.heart")
                        .foregroundColor(Color(UIColor(named: "BackgroundMessageColor")!))
                        .imageScale(.large)
                }
            }
                
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


