//
//  TriviaQuestion.swift
//  Trivia Game
//
//  Created by Cody Dubree on 10/19/18.
//  Copyright © 2018 Cody Dubree. All rights reserved.
//

import Foundation
class TriviaQuestion {
    let question : String
    let answers: [String]
    let correctAnswerIndex: Int
    var correctAnswer: String {
        return answers[correctAnswerIndex]
    }
    init (question: String, answers: [String], correctAnswerIndex: Int) {
    self.question = question
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
}
}
