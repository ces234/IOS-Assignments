//
//  TriviaResponse.swift
//  SmartiePants
//
//  Created by Caroline Schafer on 3/18/25.
//

// Define the structure for the full API response
struct TriviaResponse: Codable {
    let responseCode: Int
    let results: [Question]

    // Custom keys for decoding
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}
