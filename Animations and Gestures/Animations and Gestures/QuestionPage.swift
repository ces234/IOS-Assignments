//
//  QuestionPage.swift
//  Animations and Gestures
//
//  Created by Zoe Goldberg on 3/17/25.
//

import SwiftUI

struct QuestionPage: View {
    @State var question:Question
    @State private var questions: [Question] = [
        Question(text: "What is 2 + 2?", answers: ["3", "4", "5", "6"], correctAnswer: "4"),
        Question(text: "What is the capital of France?", answers: ["Berlin", "Madrid", "Paris", "Rome"], correctAnswer: "Paris"),
        Question(text: "Which planet is known as the Red Planet?", answers: ["Earth", "Venus", "Mars", "Jupiter"], correctAnswer: "Mars"),
        Question(text: "What is the largest ocean?", answers: ["Atlantic", "Indian", "Arctic", "Pacific"], correctAnswer: "Pacific")
    ].shuffled()
    
    @State private var currentQuestionIndex = 0
    @State private var backgroundColor: Color = Color.gray
    @State private var selectedAnswer: String? = nil
    @State private var incorrectCount = 0
    @State private var showResults = false
    @State private var animateWrong = false
    @State private var showQuiz = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Quizzo")
                .font(.title2)
            Spacer()
            Text(question.text)
                .font(.title)
                .multilineTextAlignment(.center)
                .bold()
                            
            ForEach(question.answers, id: \.self) { answer in
                Text(answer)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedAnswer == answer ? (answer == question.correctAnswer ? Color.green : Color.red) : Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .clipShape(.capsule)
                    .scaleEffect(selectedAnswer == answer && answer == questions[currentQuestionIndex].correctAnswer ? 1.5 : 1.0)
//                    .offset(y: animateWrong && selectedAnswer == answer ? -10 : 0)
//                    .animation(animateWrong ? Animation.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true) : .default, value: animateWrong)
                    .onTapGesture {
                        withAnimation(.default) {
                            if answer != question.correctAnswer {
                                incorrectCount += 1
                                animateWrong.toggle()
                            }
                        }
                    }
                    .phaseAnimator([0, 1, 2, 3], trigger: animateWrong) { view, phase in
                        view
                            .scaleEffect(phase == 1 || phase == 2 ? 1.1 : 1)
                            .rotationEffect(phase == 1 ? .degrees(-10) : .degrees(0))
                            .rotationEffect(phase == 2 ? .degrees(10) : .degrees(0))
                    } animation: { phase in
                        .easeInOut.speed(1.2) // Double the speed
                    }

//                    .onTapGesture {
//                        withAnimation(.default) {
//                            if answer.isCorrect {
//                                print("correct")
//                                correctAnswerId = answer.id
//                            }
//                            else {
//                                incorrectAnswerId = answer.id
//                            }
//                        }
//                    }

                
                //SPLIT TO NEW VIEWS WITH INCORRECT VS CORRECT ANSWER BUBBLES
//                    .phaseAnimator([0,1], trigger: correctAnswerId == answer.id) { view, phase in
//                        view
//                            .scaleEffect(phase == 1 ? 20 : 1)
//                        
//                    }


            }
            Spacer()
        }.padding()
        
    }

    
    private func goToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showResults = true
        }
        selectedAnswer = nil
    }
}

#Preview {
    QuestionPage(question: Question(text: "How many legs do frogs have?", answers: ["1", "2", "3", "4"], correctAnswer: "4"))

}
