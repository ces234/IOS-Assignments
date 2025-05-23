//
//  LandingPageView.swift
//  SmartiePants
//
//  Created by Caroline Schafer on 3/6/25.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        NavigationStack {
            
            Spacer()
            
            Text("Are you the")
                .font(.poppins(fontStyle: .largeTitle, fontWeight: .medium))
                .multilineTextAlignment(.center)
            
            Text("Smartie Pants?")
                .font(.poppins(fontStyle: .largeTitle, fontWeight: .heavy))
                .foregroundStyle(.darkBlue)
            
            HStack {
                Image("icon-img")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(25)
                    
            }
            .background(Circle().fill(Color.lightGray))
                .clipShape(Circle())
            
            Spacer()

            NavigationLink(destination: SignupView()) {
                Text("Sign up")
                    .font(.poppins(fontStyle: .headline, fontWeight: .semibold))
                    .padding()
                    .frame(maxWidth: 250)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.darkBlue))
                    .foregroundColor(.white)
            }

            
            NavigationLink(destination: LoginView()) {
                Text("Log in")
            }
            .font(.headline)
            .padding()
            .frame(maxWidth: 250)
            .background(RoundedRectangle(cornerRadius: 10).fill(.lightGray))
            .foregroundColor(.black)

            
            Spacer()
            
            
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LandingPageView()
}
