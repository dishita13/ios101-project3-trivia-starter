//
//  TriviaQuestions.swift
//  Trivia
//
//  Created by dishita on 3/12/25.
//

import Foundation

struct TriviaQuestion {

    let question: String

    let choices: [String]

    let correctAnswer: String

    let shouldShuffle: Bool?

    init(question: String, choices: [String], correctAnswer: String, shouldShuffle: Bool? = true) {

        guard choices.contains(correctAnswer) else {
            fatalError("The correct answer must be one of the choices.")
        }

        self.question = question

        self.correctAnswer = correctAnswer

        self.shouldShuffle = shouldShuffle

        // Shuffle choices only if shouldShuffle is true
        self.choices = (shouldShuffle ?? true) ? choices.shuffled() : choices
    }
}
