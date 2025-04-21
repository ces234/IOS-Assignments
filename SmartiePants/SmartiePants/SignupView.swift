//
//  SignupView.swift
//  SmartiePants
//
//  Created by Caroline Schafer on 3/6/25.
//

import SwiftUI
import SwiftData

struct SignupView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var username = ""
    @State var password = ""
    
    @Environment(\.modelContext) var modelContext
    
    @Query var users: [User]
    
    func handleSignUp() {
        
        let newUser = User(firstName: firstName, lastName: lastName, username: username, password: password)
        
        modelContext.insert(newUser)
        
        do {
            try modelContext.save()
            print("User saved successfully!")
        } catch {
            print("Error saving user: \(error)")
        }
        
    }
    var body: some View {
        
        ForEach(users) {user in
            Text(user.username)
        }
        
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
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 330, height: 40)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .textFieldStyle(PlainTextFieldStyle())
                
                HStack{
                    Spacer()
                    Button("Sign up") {
                        handleSignUp()
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

