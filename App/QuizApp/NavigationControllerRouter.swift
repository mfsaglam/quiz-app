//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Fatih Sağlam on 2.09.2023.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController
}

class NavigationControllerRouter: Router {
    private let factory: ViewControllerFactory
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeTo(result: QuizEngine.Result<String, String>) {
        
    }
}
