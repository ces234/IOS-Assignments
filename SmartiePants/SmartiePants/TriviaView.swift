//
//  TriviaView.swift
//  SmartiePants
//
//  Created by Caroline Schafer on 3/18/25.
//

import SwiftUI

struct TriviaView: View {
    
    @StateObject var triviaModel = TriviaModel()
    @State var fetchingQuestions = false
    @State var selectedCategoryNumber: Int?
    
    let categories = [
        (name: "General Knowledge", number: 9),
        (name: "Books", number: 10),
        (name: "Film", number: 11),
        (name: "Music", number: 12),
        (name: "Musical Theater", number: 13),
        (name: "Television", number: 14),
        (name: "Video Games", number: 15),
        (name: "Board Games", number: 16),
        (name: "Science & Nature", number: 17),
        (name: "Computers", number: 18),
        (name: "Mathematics", number: 19),
        (name: "Mythology", number: 20),
        (name: "Sports", number: 21),
        (name: "Geography", number: 22),
        (name: "History", number: 23),
        (name: "Politics", number: 24),
        (name: "Art", number: 25),
        (name: "Celebrities", number: 26),
        (name: "Animals", number: 27),
        (name: "Vehicles", number: 28),
        (name: "Comics", number: 29),
        (name: "Gadgets", number: 30),
        (name: "Japanese Anime & Manga", number: 31),
        (name: "Cartoon & Animations", number: 32)
    ]
    
    func loadTriviaQuestions(category: String? = nil) {
        fetchingQuestions = true
        Task {
            await triviaModel.refresh(category: category)
            fetchingQuestions = false
        }
    }
    
    var body: some View {
        VStack {
            
            Text("Select a category")
            Picker("Select a category", selection: $selectedCategoryNumber) {
                ForEach(categories, id: \.number) { category in
                    Text(category.name).tag(category.number)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            Button("Get questions") {
                // Convert selectedCategoryNumber (Int?) to a String? before passing it
                loadTriviaQuestions(category: selectedCategoryNumber != nil ? String(selectedCategoryNumber!) : nil)
            }
            
            if fetchingQuestions {
                Text("Fetching...")
                    .padding()
            } else {
                if let questions = triviaModel.questions, !questions.isEmpty {
                    List(questions, id: \.question) { question in
                        VStack(alignment: .leading) {
                            Text(question.question)
                                .font(.headline)
                            Text("Correct Answer: \(question.correctAnswer)")
                                .font(.subheadline)
                                .foregroundColor(.green)
                            if !question.incorrectAnswers.isEmpty {
                                Text("Incorrect Answers:")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                                ForEach(question.incorrectAnswers, id: \.self) { incorrectAnswer in
                                    Text(incorrectAnswer)
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    Text("No questions available.")
                        .padding()
                }
            }
        }
        .onAppear {
            loadTriviaQuestions()
        }
        .navigationTitle("Trivia Questions")
    }
}

#Preview {
    TriviaView()
}
