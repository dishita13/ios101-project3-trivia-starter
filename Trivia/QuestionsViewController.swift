//
//  QuestionsViewController.swift
//  Trivia
//
//  Created by dishita on 3/12/25.
//

import UIKit

class QuestionsViewController: UIViewController {
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    private var questionBank = [TriviaQuestion]()
    private var currentQuestionIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        questionBank = getQuestions()
        configure(with: questionBank[currentQuestionIndex])
    }

    @IBAction func choice1(_ sender: UIButton) {
        print("choice 1 selected")
        choiceSelected(sender: sender)
    }
    
    @IBAction func choice2(_ sender: UIButton) {
        choiceSelected(sender: sender)
    }
    
    @IBAction func choice3(_ sender: UIButton) {
        choiceSelected(sender: sender)
    }
    
    @IBAction func choice4(_ sender: UIButton) {
        choiceSelected(sender: sender)
    }
    
    func choiceSelected(sender: UIButton) {
        let question = questionBank[currentQuestionIndex]
        if let selectedTitle = sender.title(for: .normal), selectedTitle == question.correctAnswer {
            if currentQuestionIndex == questionBank.count - 1 {
                print("game over")
                showWinPopup()
            } else {
                print("correct!")
                currentQuestionIndex += 1
                configure(with: questionBank[currentQuestionIndex])
            }
        } else {
            print("wrong answer")
            showGameOverPopup()        }

    }
    func showWinPopup() {
        let alert = UIAlertController(title: "Congratulations!", message: "You answered all questions correctly!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            self.currentQuestionIndex = 0
            self.configure(with: self.questionBank[self.currentQuestionIndex])
        }))
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    func showGameOverPopup() {
        let alert = UIAlertController(title: "Game Over", message: "You selected the wrong answer!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.currentQuestionIndex = 0
            self.configure(with: self.questionBank[self.currentQuestionIndex])
        }))
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    private func configure(with question: TriviaQuestion) {
        questionLabel.text = question.question
        choice1.setTitle(question.choices[0], for: .normal)
        choice2.setTitle(question.choices[1], for: .normal)
        choice3.setTitle(question.choices[2], for: .normal)
        choice4.setTitle(question.choices[3], for: .normal)
    }

    

    private func getQuestions() -> [TriviaQuestion] {
        let q1 = TriviaQuestion(
            question: "What is the capital of Kazakhstan?",
            choices: ["Astana", "Almaty", "Tashkent", "Bishkek"],
            correctAnswer: "Astana",
            shouldShuffle: false
        )

        let q2 = TriviaQuestion(
            question: "What is the capital of Canada?",
            choices: ["Toronto", "Ottawa", "Vancouver", "Montreal"],
            correctAnswer: "Ottawa",
            shouldShuffle: false
        )

        let q3 = TriviaQuestion(
            question: "What is the capital of Bolivia?",
            choices: ["La Paz", "Sucre", "Santa Cruz", "Cochabamba"],
            correctAnswer: "Sucre",
            shouldShuffle: false
        )

        let q4 = TriviaQuestion(
            question: "What is the capital of Mongolia?",
            choices: ["Ulaanbaatar", "Astana", "Vladivostok", "Hohhot"],
            correctAnswer: "Ulaanbaatar",
            shouldShuffle: false
        )
        
        let q5 = TriviaQuestion(
            question: "What is the capital of Australia?",
            choices: ["Sydney", "Melbourne", "Canberra", "Brisbane"],
            correctAnswer: "Canberra",
            shouldShuffle: false
        )
        
        let q6 = TriviaQuestion(
            question: "What is the capital of Egypt?",
            choices: ["Cairo", "Alexandria", "Giza", "Luxor"],
            correctAnswer: "Cairo",
            shouldShuffle: false
        )

        let q7 = TriviaQuestion(
            question: "What is the capital of Germany?",
            choices: ["Frankfurt", "Munich", "Berlin", "Hamburg"],
            correctAnswer: "Berlin",
            shouldShuffle: false
        )

        return [q1, q2, q3, q4, q5, q6, q7]
    }
}
