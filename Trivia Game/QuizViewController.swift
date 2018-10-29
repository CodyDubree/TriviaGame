//
//  ViewController.swift
//  Trivia Game
//
//  Created by Cody Dubree on 10/18/18.
//  Copyright © 2018 Cody Dubree. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var answerAButton: UIButton!
    @IBOutlet weak var answerBButton: UIButton!
    @IBOutlet weak var answerCButton: UIButton!
    @IBOutlet weak var answerDButton: UIButton!
    
    
    
    var questionsPlaceholder = [TriviaQuestion]()
    var questions = [TriviaQuestion]()
    var currentIndex: Int!
    var score = 0 {
        didSet {
            scoreLabel.text = "score: \(score)"
        }
    }
    
    var currentQuestion: TriviaQuestion! {
        didSet {
            if let currentQuestion = currentQuestion {
                QuestionLabel.text = currentQuestion.question
                answerAButton.setTitle(currentQuestion.answers[0], for: .normal)
                answerBButton.setTitle(currentQuestion.answers[1], for: .normal)
                answerCButton.setTitle(currentQuestion.answers[2], for: .normal)
                answerDButton.setTitle(currentQuestion.answers[3], for: .normal)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateQuestions()
        getNewQuestion()
        setNewColors()
        
    }
    
    func populateQuestions() {
        let question1 = TriviaQuestion(question: "In what year where you born?", answers: ["2000", "NOONE CARES", "2001", "1999"], correctAnswerIndex: 1)
        let question2 = TriviaQuestion(question: "why did the chicken cross the road?", answers: ["to get to the other side", "he didnt", "he wanted to die","the butcher got him before he started across"], correctAnswerIndex: 3)
        questions = [question1,question2]
        
    }
    func getNewQuestion() {
        if questions.count > 0 {
            currentIndex = Int.random(in: 0..<questions.count)
            currentQuestion = questions[currentIndex]
        } else{
            showGameOverAlert()
        }
    }
    func showGameOverAlert(){
        let endAlert = UIAlertController(title: "Trivia Results", message: "Game over your score was \(score) out of \(questionsPlaceholder.count)", preferredStyle: UIAlertController.Style.alert)
        let resetAction = UIAlertAction(title: "Reset", style: UIAlertAction.Style.default){ UIAlertAction in
            self.resetGame()
        }
   endAlert.addAction(resetAction)
        self.present(endAlert, animated: true, completion: nil)
    }
    let backgroundColors = [
        UIColor(red: 255/255, green: 127/255, blue: 88/255, alpha: 1.0),
        UIColor(red: 63/255, green: 127/255, blue: 200/255, alpha: 1.0),
        UIColor(red: 47/255, green: 200/255, blue: 66/255, alpha: 1.0),
        UIColor(red: 255/255, green: 200/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 50/255, green: 100/255, blue: 255/255, alpha: 1.0),
        UIColor(red: 123/255, green: 13/255, blue: 69/255, alpha: 1.0)
    ]
    
    func setNewColors(){
        let randomNumber = Int.random(in: 1...100)
        let randomColorA = backgroundColors[randomNumber % 4]
        let randomColorB = backgroundColors[(randomNumber + 1) % 4]
        let randomColorC = backgroundColors[(randomNumber + 2) % 4]
        let randomColorD = backgroundColors[(randomNumber + 3) % 4]
        
        answerAButton.backgroundColor = randomColorA
        answerBButton.backgroundColor = randomColorB
        answerCButton.backgroundColor = randomColorC
        answerDButton.backgroundColor = randomColorD
    }
    
    func resetGame() {
        score = 0
        
        if !questions.isEmpty {
            questionsPlaceholder.append(contentsOf: questions)
            questions.removeAll()
        }
        questions = questionsPlaceholder
        questionsPlaceholder.removeAll()
        getNewQuestion()
        
    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        if currentQuestion.correctAnswerIndex == sender.tag {
            score += 1
            showCorrectAnswerAlert()
        }else{
            showIncorrectAnswerAlert()
        }
    }
    func showCorrectAnswerAlert() {
        let correctAlert = UIAlertController(title: "Correct", message: "\(currentQuestion.correctAnswer)is the correct answer", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Thank you", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        correctAlert.addAction(okayAction)
        self.present(correctAlert, animated: true, completion: nil)
    }
    func showIncorrectAnswerAlert(){
        let incorrectAlert = UIAlertController(title: "Incorrect", message: "\(currentQuestion.correctAnswer) is the correct answer", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "...sorry", style: UIAlertAction.Style.default){
            UIAlertAction in
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        incorrectAlert.addAction(okayAction)
        self.present(incorrectAlert, animated: true, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        resetGame()
    }
    @IBAction func unwindToQuizScreen (segue: UIStoryboardSegue){}
    
}


