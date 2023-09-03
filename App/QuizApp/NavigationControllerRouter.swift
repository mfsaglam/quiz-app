//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Fatih Sağlam on 2.09.2023.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController
    
    func resultsViewController(for result: Result<Question<String>, String>) -> UIViewController
}

class NavigationControllerRouter: Router {
    private let factory: ViewControllerFactory
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: Question<String>, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        show(viewController)
        
    }
    
    func routeTo(result: Result<Question<String>, String>) {
        let viewController = factory.resultsViewController(for: result)
        show(viewController)
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
