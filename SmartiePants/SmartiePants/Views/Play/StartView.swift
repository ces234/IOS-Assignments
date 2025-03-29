//
//  StartView.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/29/25.
//

import SwiftUI

struct StartView: View {
    @State var selectedCategory = "Entertainment: Books"
    @State var startQuiz = false
    
    var body: some View {
        VStack(alignment: .center) {
            Text(selectedCategory)
                .font(startQuiz ? .title2 : .title)
                .bold()
            
            Rectangle()
                .frame(width: 275, height: 2)
                .padding(.bottom)
            
            if startQuiz {
                QuestionPage()
            } else {
                Button {
                    // TODO: GO TO QUESTION
                    withAnimation(.bouncy(duration: 0.7)){
                        startQuiz = true
                    }
                } label: {
                    HStack {
                        Text("Play")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width:20, height: 20)
                            .foregroundColor(Color.black)
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    
                }.buttonStyle(.plain)
                .background(Color.gray.opacity(0.15))
                .clipShape(.rect(cornerRadius: 10))
            }
            
        }.padding()
    }
}

#Preview {
    StartView()
}
