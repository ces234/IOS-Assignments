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
    
    @State private var shouldNavigate = false
    
    @Environment(\.modelContext) var modelContext
    
    @Query var users: [User]
    
    func handleSignUp() {
        let newUser = User(firstName: firstName, lastName: lastName, username: username, password: password)
        modelContext.insert(newUser)
        
        do {
            try modelContext.save()
            print("User saved successfully!")
            shouldNavigate = true
        } catch {
            print("Error saving user: \(error)")
        }
    }

    var body: some View {
        
        NavigationStack {
            
            Spacer()
            
            Text("Are you the")
                .font(.poppins(fontStyle: .largeTitle, fontWeight: .medium))
                .multilineTextAlignment(.center)
            
            Text("Smartie Pants?")
                .font(.poppins(fontStyle: .largeTitle, fontWeight: .bold))
                .foregroundStyle(.darkBlue)
            
            
            VStack{
                Text("Sign up")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.poppins(fontStyle: .title2, fontWeight: .semibold))
                
                HStack (spacing: 10){
                    TextField("First Name", text: $firstName)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.poppins(fontStyle: .body, fontWeight: .regular))
                    
                    TextField("Last Name", text: $lastName)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.poppins(fontStyle: .body, fontWeight: .regular))
                }
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.poppins(fontStyle: .body, fontWeight: .regular))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.poppins(fontStyle: .body, fontWeight: .regular))
                
                HStack{
                    Spacer()
                    NavigationLink(destination: LandingPageView(), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    Button("Sign up") {
                        handleSignUp()
                    }
                    .font(.poppins(fontStyle: .headline, fontWeight: .semibold))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.darkBlue))
                    .foregroundColor(.white)
                    
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

