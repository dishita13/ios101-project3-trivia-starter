//
//  TriviaService.swift
//  Access the OpenTDB API and format the response
//
//  Created by dishita on 3/26/25.
//

import Foundation
struct TriviaAPIResponse: Decodable {
    let results: [CurrentTriviaQuestion]
}
struct CurrentTriviaQuestion: Decodable{
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case difficulty = "difficulty"
        case category = "category"
        case question = "question"
        case correct_answer = "correct_answer"
        case incorrect_answers = "incorrect_answers"
    }
}

class TriviaService {
    static func fetchTriviaQuestion(
        amount: Int,
        category: Int,
        difficulty: String,
        type: String,
        completion: (([CurrentTriviaQuestion]) -> Void)? = nil
    ) {
        let url = URL(string: "https://opentdb.com/api.php?amount=\(amount)&category=\(category)&difficulty=\(difficulty)&type=\(type)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else {
                assertionFailure("Invalid response or data")
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TriviaAPIResponse.self, from: data)
                DispatchQueue.main.async {
                    completion?(response.results)
                }
            } catch {
                assertionFailure("Failed to decode: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
