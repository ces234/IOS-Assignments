//
//  QuestionModel.swift
//  SmartiePants
//
//  Created by Caroline Schafer on 3/18/25.
//


import Foundation


class TriviaModel: ObservableObject {
    @Published var triviaResponse: TriviaResponse?
    @Published var questions: [Question]?
    
    func refresh(category: String? = nil) async {
        self.triviaResponse = await getTriviaDetails(category: category)
        self.questions = triviaResponse?.results
        print("Questions: \(questions)")
    }
    
    private func getTriviaDetails(category: String? = nil) async -> TriviaResponse? {
        
        var urlString = "https://opentdb.com/api.php?amount=10"
        if let category = category{
            urlString += "&category=\(category)"
        }
                
        let session = URLSession(configuration: .default)
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            do{
                let (data, _) = try await session.data(for: request)
                let decoder = JSONDecoder()
                let triviaResponse = try decoder.decode(TriviaResponse.self, from: data)
                
                return triviaResponse

            }
            catch {
                print("Error: \(error.localizedDescription)")
            }

        }
        return nil
    }
    
}
