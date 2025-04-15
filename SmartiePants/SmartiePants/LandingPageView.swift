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
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text("Smartie Pants?")
                .font(.largeTitle)
                .bold()
            
            Spacer()

            
            NavigationLink(destination: SignupView()) {
                Text("Sign up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: 250)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                    .foregroundColor(.white)
            }

            
            NavigationLink(destination: BottomBarView()) {
                Text("Log in")
            }
            .font(.headline)
            .padding()
            .frame(maxWidth: 250)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
            .foregroundColor(.black)

            
            Spacer()
            
            
        }
        .padding()
    }
}

#Preview {
    LandingPageView()
}
