//
//  SignupView.swift
//  SmartiePants
//
//  Created by Caroline Schafer on 3/6/25.
//

import SwiftUI

struct SignupView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            
            Spacer()
            
            Text("Are you the")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text("Smartie Pants?")
                .font(.largeTitle)
                .bold()
            
            
            VStack{
                Text("Sign up")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                    .font(.system(size: 24))
                
                HStack (spacing: 10){
                    TextField("First Name", text: $firstName)
                        .padding()
                        .frame(width: 160, height: 40)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .textFieldStyle(PlainTextFieldStyle())
                    TextField("Last Name", text: $lastName)
                        .padding()
                        .frame(width: 160, height: 40)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 330, height: 40)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .textFieldStyle(PlainTextFieldStyle())
                
                TextField("Password", text: $password)
                    .padding()
                    .frame(width: 330, height: 40)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .textFieldStyle(PlainTextFieldStyle())
                
                HStack{
                    Spacer()
                    Button("Sign up") {
                        
                    }
                        .font(.headline)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                        .foregroundColor(.white)
                        .frame(maxWidth: 100)
                }
                
                

                    

            }
            .padding()
            
            
            Spacer()
            
            
            
        }
        .padding()
    }
}

#Preview {
    SignupView()
}

