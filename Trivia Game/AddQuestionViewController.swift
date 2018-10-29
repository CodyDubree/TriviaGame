//
//  AddQuestionViewController.swift
//  Trivia Game
//
//  Created by Cody Dubree on 10/19/18.
//  Copyright © 2018 Cody Dubree. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {
    @IBOutlet weak var questionTF: UITextField!
    
    @IBOutlet weak var answerATF: UITextField!
    
    
    @IBOutlet weak var answerBTF: UITextField!
    
    
    @IBOutlet weak var answerCTF: UITextField!
    
    
    @IBOutlet weak var answerDTF: UITextField!
    
    
    @IBOutlet weak var correctAnswerSelector: UISegmentedControl!
    
    var  newTrivia: TriviaQuestion?
    
    
    @IBAction func add(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
    }
   
    @IBAction func addTapped(_ sender: Any) {
        guard let question = questionTF.text, !question.isEmpty,
            let a = answerATF.text, !a.isEmpty,
            let b = answerBTF.text, !b.isEmpty,
            let c = answerCTF.text, !c.isEmpty,
            let d = answerDTF.text, !d.isEmpty
            
            else {
                let errorAlert = UIAlertController(title: "Error", message: "Please fill all fields or press cancel to return to quiz", preferredStyle: UIAlertController.Style.alert)
                let dismissAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) {UIAlertAction in}
                errorAlert.addAction(dismissAction)
                self.present(errorAlert, animated: true, completion: nil)
                return
        }
        
        newTrivia = TriviaQuestion(question: question, answers: [a,b,c,d], correctAnswerIndex: correctAnswerSelector.selectedSegmentIndex)
        performSegue(withIdentifier: "unwindSegueToQuizScreen", sender: self)
        
    }
    
    @IBAction func returnToQuizScreen(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindSegueToQuizScreen", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destinationVC = segue.destination as? QuizViewController,
            let newTriviaQuestion = newTrivia
            else {
                return
        }
        destinationVC.questions.append(newTriviaQuestion)
        destinationVC.resetGame()
    }
}
