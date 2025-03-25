//
//  QuestionPage.swift
//  Animations and Gestures
//
//  Created by Zoe Goldberg on 3/17/25.
//

import SwiftUI

struct QuestionPage: View {
    @State var question:Question = Question(text: "What is 2 + 2?", answers: [Answer(isCorrect: false, text: "3"), Answer(isCorrect: true, text: "4"), Answer(isCorrect: false, text: "5"), Answer(isCorrect: false, text: "6")])
    
    @State var questions:[Question] = [
        Question(text: "What is 2 + 2?", answers: [Answer(isCorrect: false, text: "3"), Answer(isCorrect: true, text: "4"), Answer(isCorrect: false, text: "5"), Answer(isCorrect: false, text: "6")]),
        Question(text: "What is the capital of France?", answers: [Answer(isCorrect: false, text: "Berlin"), Answer(isCorrect: false, text: "Madrid"), Answer(isCorrect: true, text: "Paris"), Answer(isCorrect: false, text: "Rome")]),
        Question(text: "Which planet is known as the Red Planet?", answers: [Answer(isCorrect: false, text: "Earth"), Answer(isCorrect: false, text: "Venus"), Answer(isCorrect: false, text: "Jupiter"), Answer(isCorrect: true, text: "Mars")]),
        Question(text: "What is the largest ocean?", answers: [Answer(isCorrect: true, text: "Pacific"), Answer(isCorrect: false, text: "Indian"), Answer(isCorrect: false, text: "Atlantic"), Answer(isCorrect: false, text: "Arctic")]),
    ].shuffled()
    
    @State private var currentQuestionIndex = 0
    @State private var backgroundColor: Color = Color.gray
    @State private var selectedAnswer: Answer? = nil
    @State private var incorrectCount = 0
    @State private var showResults = false
    @State private var showQuiz = false
    
    var body: some View {
        VStack {
            
            if(showResults) {
                ResultsPage(incorrectCount: incorrectCount, onRestart: {restartQuiz()})
            }
            else {
                Text(questions[currentQuestionIndex].text)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .bold()
                
                ForEach(questions[currentQuestionIndex].answers, id: \.self) { answer in
                    AnswerView(
                        answer: answer,
                        onTap: { handleAnswerSelection(answer) }
                    )
                    .padding(.bottom, 7.0)
                }
            }
            
            
        }.padding()
        
    }
    
    private func handleAnswerSelection(_ answer: Answer) {
        selectedAnswer = answer
        
        if answer.isCorrect {
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
                
                selectedAnswer = nil
            } else {
                showResults = true
            }
           
        } else {
            incorrectCount += 1
        }
    }
    
    private func restartQuiz() {
        incorrectCount = 0
        currentQuestionIndex = 0
        showResults = false
        questions.shuffle()
    }

}

#Preview {
    QuestionPage()

}
