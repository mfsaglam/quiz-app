//
//  iOSViewControllerFactoryTests.swift
//  QuizAppTests
//
//  Created by Fatih Sağlam on 10.09.2023.
//

import UIKit
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTests: XCTestCase {
    
    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswer_createsViewControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: .singleAnswer("Q1")).question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createsViewControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: .singleAnswer("Q1")).options, options)
    }
    
    func test_questionViewController_singleAnswer_createsViewControllerWithSingleSelection() {
        let controller = makeQuestionController(question: .singleAnswer("Q1"))
        
        _ = controller.view
        
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    func test_questionViewController_multipleAnswer_createsViewControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: .multipleAnswer("Q1")).question, "Q1")
    }
    
    func test_questionViewController_multipleAnswer_createsViewControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: .multipleAnswer("Q1")).options, options)
    }
    
    func test_questionViewController_multipleAnswer_createsViewControllerWithSingleSelection() {
        let controller = makeQuestionController(question: .multipleAnswer("Q1"))
        
        _ = controller.view
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: Helpers
    
    func makeSUT(options: Dictionary<Question<String>, [String]>) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("Q1")) -> QuestionViewController {

        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
}
