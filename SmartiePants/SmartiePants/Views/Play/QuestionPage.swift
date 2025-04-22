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
        
        let question:Question? = questions.isEmpty ? nil : questions[currentIndex]
        let allAnswers = shuffledAnswers

        VStack {
            HStack {
                HStack {
                    Text("Score: \(currScore)")
                        .font(.poppins(fontStyle: .headline, fontWeight: .medium))
                        .foregroundStyle(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                }
                .background(.lightGray)
                .clipShape(.rect(cornerRadius: 10))
                
                Spacer()
                
                CountdownTimerView(totalTime: 10, isTimerFinished: $isTimerFinished, timerRunning: $timerRunning)
            }.padding()
        }
        .onAppear {
            if !questions.isEmpty {
                let firstQuestion = questions[currentIndex]
                shuffledAnswers = (firstQuestion.incorrectAnswers + [firstQuestion.correctAnswer]).shuffled()
            }
        }

        
        VStack(alignment: .leading) {
            Text("Question \(currentIndex + 1)")
                .font(.poppins(fontStyle: .title2, fontWeight: .bold))
                .padding(.horizontal)
            
            
            HStack {
                Text("\(question?.question ?? "Error getting question")")
                    .font(.poppins(fontStyle: .title3, fontWeight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    
            }
            .frame(maxWidth: .infinity)
            .background(.darkBlue)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal)
            
            VStack{
                ForEach(allAnswers, id: \.self) { answer in
                    Button{
                        answerSelected = true
                        timerRunning = false
                        
                        if answer == question?.correctAnswer {
                            currScore += 1
                        }
                    } label: {
                        AnswerRow(answerText: answer, isCorrect: answer == question?.correctAnswer, showAnswer: isTimerFinished || answerSelected)
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
                    withAnimation(.spring(duration: 0.6)){
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
                    }
                } label: {
                    HStack {
                        Text("Next")
                            .font(.poppins(fontStyle: .body, fontWeight: .semibold))
                            .foregroundStyle(.darkBlue)
                            .padding(.vertical)
                        
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.darkBlue)
                    }
                    .padding(.horizontal, 20)
                    .background(Color.gray.opacity(0.15))
                    .clipShape(.rect(cornerRadius: 10))
                }.buttonStyle(.plain)
                    .padding(.horizontal)
            }.padding()
        }
        Spacer()
    }
        
}

#Preview {
    @Previewable @State var score = 100
    QuestionPage(onNext: {}, questions: [Question](), currScore: $score)
        .environmentObject({
            let mockSession = SessionManager()
            mockSession.currentUser = User(
                firstName: "Caroline",
                lastName: "Caroline",
                username: "Schafer",
                password: "1234"
            )
            mockSession.currentUser?.categoryPlayCounts = ["Sports": 10, "Geography": 20, "Entertaiment: Books": 15]
            mockSession.currentUser?.recentCategories = ["Sports", "Science & Nature", "Geography"]
            return mockSession
        }())
}
