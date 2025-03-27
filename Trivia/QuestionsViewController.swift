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
    private var wrongAnswers = 0
    private var totalQuestions = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        getQuestions()
    }

    @IBAction func choice1(_ sender: UIButton) {
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
                showGameEndPopup()
            } else {
                print("correct!")
                currentQuestionIndex += 1
                configure(with: questionBank[currentQuestionIndex])
            }
        } else {
            print("wrong answer")
            showWrongAnswerPopup(correctAnswer: question.correctAnswer)
        }

    }
    func showGameEndPopup() {
        if self.wrongAnswers == 0{
            let alert = UIAlertController(title: "Congratulations!", message: "You answered all questions correctly!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
                self.currentQuestionIndex = 0
                self.wrongAnswers = 0
                self.configure(with: self.questionBank[self.currentQuestionIndex])
            }))
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: "Score:", message: "You answered \(totalQuestions - self.wrongAnswers)/\(totalQuestions) questions correctly!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
                self.currentQuestionIndex = 0
                self.wrongAnswers = 0
                self.configure(with: self.questionBank[self.currentQuestionIndex])
            }))
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            }
        }
    }

    func showWrongAnswerPopup(correctAnswer: String) {
        let alert = UIAlertController(
            title: "Wrong Answer",
            message: "You selected the wrong answer! The correct answer was: \(correctAnswer)",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Restart", style: .destructive, handler: { _ in
            self.currentQuestionIndex = 0
            self.wrongAnswers = 0
            self.configure(with: self.questionBank[self.currentQuestionIndex])
        }))

        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            self.wrongAnswers += 1
            self.currentQuestionIndex += 1

            if self.currentQuestionIndex >= self.questionBank.count {
                self.showGameEndPopup()
            } else {
                self.configure(with: self.questionBank[self.currentQuestionIndex])
            }
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

    private func getQuestions() {
        TriviaService.fetchTriviaQuestion(amount: totalQuestions, category: 9, difficulty: "easy", type: "multiple") { fetchedQuestions in
            self.questionBank = fetchedQuestions.map { question in
                let allChoices = (question.incorrect_answers + [question.correct_answer]).shuffled()
                return TriviaQuestion(
                    question: question.question,
                    choices: allChoices,
                    correctAnswer: question.correct_answer,
                    shouldShuffle: false
                )
            }
            self.currentQuestionIndex = 0
            self.configure(with: self.questionBank[self.currentQuestionIndex])
        }
    }
}
