//
//  iOSViewControllerFactoryTests.swift
//  QuizAppTests
//
//  Created by Fatih Sağlam on 10.09.2023.
//

import UIKit
import XCTest
import QuizEngine
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
                
        XCTAssertFalse(controller.allowsMultipleSelection)
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
        
        XCTAssertTrue(controller.allowsMultipleSelection)
    }
    
    func test_resultsViewController_createsControllerWithTitle() {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.title, results.presenter.title)
    }
    
    func test_resultsViewController_createsControllerWithSummary() {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.summary, results.presenter.summary)
    }
    
    func test_resultsViewController_createsControllerWithPresentableAnswers() {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswers.count)
    }
    
    // MARK: Helpers
    
    func makeSUT(options: Dictionary<Question<String>, [String]> = [:], correctAnswers: Dictionary<Question<String>, Set<String>> = [:]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(
            questions: [singleAnswerQuestion, multipleAnswerQuestion],
            options: options,
            correctAnswers: correctAnswers
        )
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("Q1")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
    
    func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
        let userAnswers = [singleAnswerQuestion: Set(["A1"]), multipleAnswerQuestion: Set(["A1", "A2"])]
        let correctAnswers = [singleAnswerQuestion: Set(["A1"]), multipleAnswerQuestion: Set(["A1", "A2"])]
        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        let orderedOptions = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        let result = Result(answers: userAnswers, score: 2)
        
        let sut = makeSUT(correctAnswers: correctAnswers)
        
        let presenter = ResultsPresenter(result: result, questions: questions, options: orderedOptions, correctAnswers: correctAnswers)

        let controller = sut.resultsViewController(for: result) as! ResultsViewController
        return (controller, presenter)
    }
}