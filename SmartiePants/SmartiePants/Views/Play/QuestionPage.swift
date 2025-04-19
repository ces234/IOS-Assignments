//
//  QuestionPage.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/29/25.
//

import SwiftUI

struct QuestionPage: View {
    @State var onNext: () -> Void
    @State var questions: [Question]
    @State private var currentIndex = 0
    @State var answerSelected = false
    @State private var isTimerFinished = false
    @State private var timerRunning = true
    @Binding var currScore: Int
    @State private var shuffledAnswers: [String] = []



    var body: some View {
        
        let question = questions[currentIndex]
        let allAnswers = shuffledAnswers

        
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
        .onAppear {
            let firstQuestion = questions[currentIndex]
            shuffledAnswers = (firstQuestion.incorrectAnswers + [firstQuestion.correctAnswer]).shuffled()
        }

        
        VStack(alignment: .leading) {
            Text("Question \(currentIndex + 1)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            
            HStack {
                Text("\(question.question)")
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
            
            VStack{
                ForEach(allAnswers, id: \.self) { answer in
                    Button{
                        answerSelected = true
                        timerRunning = false
                        
                        if answer == question.correctAnswer {
                            currScore += 1
                        }
                    } label: {
                        AnswerRow(answerText: answer, isCorrect: answer == question.correctAnswer, showAnswer: isTimerFinished || answerSelected)
                    }
                    .buttonStyle(.plain)
                    .disabled(isTimerFinished || answerSelected)
                }
            }.padding(.horizontal)

        }
        Spacer()
        
        if answerSelected || isTimerFinished {
            HStack{
                Spacer()
                Button{
                    if currentIndex + 1 < questions.count {
                        currentIndex += 1
                        answerSelected = false
                        isTimerFinished = false
                        timerRunning = true
                        let nextQuestion = questions[currentIndex]
                        shuffledAnswers = (nextQuestion.incorrectAnswers + [nextQuestion.correctAnswer]).shuffled()
                    } else {
                        onNext()
                    }
                } label: {
                    HStack {
                        Text("Next")
                            .padding(.vertical)
                        
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
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
