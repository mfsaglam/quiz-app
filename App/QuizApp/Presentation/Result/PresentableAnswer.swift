//
//  PresentableAnswer.swift
//  QuizApp
//
//  Created by Fatih Sağlam on 1.09.2023.
//

import Foundation

struct PresentableAnswer: Equatable {
    let question: String
    let answer: String
    let wrongAnswer: String?
}
