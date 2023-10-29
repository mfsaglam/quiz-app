//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Fatih Sağlam on 2.09.2023.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    private let factory: ViewControllerFactory
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: Question<String>, answerCallback: @escaping (Set<String>) -> Void) {
        switch question {
        case .singleAnswer:
            show(factory.questionViewController(for: question, answerCallback: answerCallback))
        case.multipleAnswer:
            let button = UIBarButtonItem(title: "Submit", style: .done, target: nil, action: nil)
            let buttonController = SubmitButtonController(button, answerCallback)
            let controller = factory.questionViewController(for: question) { selection in
                buttonController.update(selection)
            }
            controller.navigationItem.rightBarButtonItem = button
            show(controller)
        }
        
        
    }
    
    func routeTo(result: Result<Question<String>, Set<String>>) {
        let viewController = factory.resultsViewController(for: result)
        show(viewController)
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}

private class SubmitButtonController: NSObject {
    let button: UIBarButtonItem
    let callback: (Set<String>) -> Void
    
    private var model: Set<String> = []
    
    init(_ button: UIBarButtonItem, _ callback: @escaping (Set<String>) -> Void) {
        self.button = button
        self.callback = callback
        super.init()
        self.setup()
    }
    
    private func setup() {
        button.target = self
        button.action = #selector(fireCallback)
        updateButtonState()
    }
    
    func update(_ model: Set<String>) {
        self.model = model
        updateButtonState()
    }
    
    @objc private func fireCallback() {
        callback(model)
    }
    
    private func updateButtonState() {
        button.isEnabled = !model.isEmpty
    }
}
