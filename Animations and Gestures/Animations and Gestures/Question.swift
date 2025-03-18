//
//  Question.swift
//  Animations and Gestures
//
//  Created by Zoe Goldberg on 3/17/25.
//

import Foundation

struct Answer : Hashable {
    var id = UUID()
    var isCorrect:Bool
    var text:String
}

struct Question {
    var text: String
    var answers: [Answer]
//    var correctAnswer: Answer
}
