//
//  Question.swift
//  SmartiePants
//
//  Created by Caroline Schafer on 3/18/25.
//

import Foundation

struct Question: Codable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    // Custom decoding to handle HTML entities
    enum CodingKeys: String, CodingKey {
        case type, difficulty, category, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
    
    // Custom initializer to decode HTML entities
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try values.decode(String.self, forKey: .type)
        difficulty = try values.decode(String.self, forKey: .difficulty)
        category = try values.decode(String.self, forKey: .category)
        question = try Question.decodeHTML(try values.decode(String.self, forKey: .question))
        correctAnswer = try Question.decodeHTML(try values.decode(String.self, forKey: .correctAnswer))
        incorrectAnswers = try values.decode([String].self, forKey: .incorrectAnswers).map { Question.decodeHTML($0) }
    }
    
    // Utility function to decode HTML entities
    private static func decodeHTML(_ string: String) -> String {
        guard let data = string.data(using: .utf8) else { return string }
        let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        return attributedString?.string ?? string
    }
}
