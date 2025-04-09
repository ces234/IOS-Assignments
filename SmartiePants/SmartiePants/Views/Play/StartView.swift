//
//  StartView.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/29/25.
//

import SwiftUI

struct StartView: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedCategory = "Entertainment: Books"
    @State var startQuiz = false
    
    @State var showResults = false
    // TODO: Load questions on this view and pass into QuestionPage?
    
    var body: some View {
        VStack(alignment: .center) {
            if !startQuiz && !showResults {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width:12, height: 12)
                                .foregroundColor(Color.black)
                            
                            Text("Back")
                                .font(.footnote)
                                .padding(.leading, 5)
                                .padding(.vertical, 10)
                        }
                        .padding(.horizontal, 20)
                        .background(Color.gray.opacity(0.15))
                        .clipShape(.rect(cornerRadius: 10))
                    }.buttonStyle(.plain)
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
            
            Spacer()
                        
            Text(selectedCategory)
                .font(startQuiz ? .title2 : .title)
                .bold()
//                .padding(.top)
            
            Rectangle()
                .frame(width: 275, height: 2)
                .padding(.bottom)
            
            if startQuiz {
                QuestionPage(onNext: {
                    //TODO: CHANGE THIS TO GO TO NEXT QUESTION
                    withAnimation(.bouncy(duration: 0.6)){
                        startQuiz = false
                        showResults = true
                    }
                })
            } else if showResults {
                ResultPage(onReplay: {
                    withAnimation(.bouncy(duration: 0.7)){
                        showResults = false
                    }
                })
            } else {
                Button {
                    // TODO: GO TO FIRST QUESTION
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
            
            Spacer()
            
        }.padding()
        
       
    }
}

#Preview {
    StartView()
}
