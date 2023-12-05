//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Fatih Sağlam on 10.09.2023.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    typealias Answers = [(question: Question<String>, answer: [String])]

    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
    
    func resultsViewController(for userAnswers: Answers) -> UIViewController
}
