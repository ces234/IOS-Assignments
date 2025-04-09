//
//  QuestionPage.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/29/25.
//

import SwiftUI

struct QuestionPage: View {
    @State var onNext:() -> Void
    @State var category = "Entertainment: Books"
    
    //TODO: May have to move this into StartView() to know when to go to results page
    @State var answerSelected = false
    @State private var isTimerFinished = false
    @State private var timerRunning = true
    @State private var currScore = 0
    
    /* TODO: Repalce this with models? */
    @State private var currQuestionIndex = 1
    @State private var currQuestion = "In which classic novel is there a character named Homer Simpson?"
    @State private var answers = ["Catch-22", "The Day of the Locust", "Of Mice and Men", "A Separate Peace"]
    @State private var correctAnswer = "The Day of the Locust"
    
//    init(onNext:()->Void) {
//        _onNext = State(wrappedValue: onNext)
//    }
//    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("Score")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                }
                .background(Color.gray.opacity(0.15))
                .clipShape(.rect(cornerRadius: 10))
                HStack {
                    Text("\(currScore)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                }
                .background(Color.gray.opacity(0.15))
                .clipShape(.rect(cornerRadius: 10))
                
                Spacer()
                
                CountdownTimerView(totalTime: 10, isTimerFinished: $isTimerFinished, timerRunning: $timerRunning)
            }.padding()
        }
        
        VStack(alignment: .leading) {
            Text("Question \(currQuestionIndex)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            HStack {
                Text("\(currQuestion)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .multilineTextAlignment(.center)
            }
            .background(Color.gray)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal)
            
            VStack {
                ForEach(answers, id: \.self) { answer in
                    Button {
                        answerSelected = true
                        timerRunning = false
                        /* TODO: ADD POINTS SYSTEM HERE - UPDATE SCORE */
                    } label: {
                        AnswerRow(answerText: answer, isCorrect: answer == correctAnswer, showAnswer: isTimerFinished || answerSelected)
                    }.buttonStyle(.plain)
                        .disabled(isTimerFinished || answerSelected)
                }
            }.padding(.horizontal)
            
           
        }
        Spacer()
        
        if answerSelected || isTimerFinished {
            HStack {
                Spacer()
                Button {
                    onNext()
                } label: {
                    HStack {
                        Text("Next")
                            .padding(.vertical)
                        
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width:16, height: 16)
                            .foregroundColor(Color.black)
                    }
                    .padding(.horizontal, 20)
                    .background(Color.gray.opacity(0.15))
                    .clipShape(.rect(cornerRadius: 10))
                }.buttonStyle(.plain)
                    .padding(.horizontal)
            }.padding()
        }        
           
        
       
    }
}

#Preview {    
    QuestionPage(onNext: {})
}
