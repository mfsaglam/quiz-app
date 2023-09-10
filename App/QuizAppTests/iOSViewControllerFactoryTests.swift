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
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")

    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswer_createsViewControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).title, presenter.title)
    }
    
    func test_questionViewController_singleAnswer_createsViewControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createsViewControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_singleAnswer_createsViewControllerWithSingleSelection() {
        let controller = makeQuestionController(question: singleAnswerQuestion)
        
        _ = controller.view
        
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    func test_questionViewController_multipleAnswer_createsViewControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).title, presenter.title)
    }
    
    func test_questionViewController_multipleAnswer_createsViewControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).question, "Q1")
    }
    
    func test_questionViewController_multipleAnswer_createsViewControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_multipleAnswer_createsViewControllerWithSingleSelection() {
        let controller = makeQuestionController(question: multipleAnswerQuestion)
        
        _ = controller.view
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: Helpers
    
    func makeSUT(options: Dictionary<Question<String>, [String]>) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(
            questions: [singleAnswerQuestion, multipleAnswerQuestion],
            options: options
        )
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("Q1")) -> QuestionViewController {

        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
}
