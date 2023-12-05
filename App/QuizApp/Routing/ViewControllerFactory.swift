//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Fatih Sağlam on 10.09.2023.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    typealias Answers = [(question: Question<String>, answers: [String])]

    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
    
    func resultsViewController(for userAnswers: Answers) -> UIViewController
    
    func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController
}

extension ViewControllerFactory {
    func resultsViewController(for userAnswers: Answers) -> UIViewController {
        return UIViewController()
    }
}
