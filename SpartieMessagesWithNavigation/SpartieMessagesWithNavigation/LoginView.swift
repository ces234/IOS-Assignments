//
//  LoginView.swift
//  SpartieMessagesWithNavigation
//
//  Created by Caroline Schafer on 2/11/25.
//

import SwiftUI



struct LoginView: View {
//    @Environment(\.dismiss) var dismiss
    @Binding var isShowingLogin: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    var body: some View{
        VStack {
            Text("Sign In")
                .font(.largeTitle)
            
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .padding()
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
                .padding()
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button(action: login) {
                Text("Sign In")
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background(Color(UIColor(named: "AccentColor 1")!))
            .foregroundColor(.white)
            .cornerRadius(12)

        }.padding()
            .interactiveDismissDisabled()

    }

    
    func login() {
        if username == "spartie" && password == "messages" {
            isShowingLogin = false
        } else {
            errorMessage = "Invalid username or password"
        }
    }
}


#Preview {
    LoginView(isShowingLogin: .constant(true))
}
