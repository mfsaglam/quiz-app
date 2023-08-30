//
//  ResultsViewControllerTests.swift
//  QuizAppTests
//
//  Created by Fatih Sağlam on 28.08.2023.
//

import Foundation
import XCTest
@testable import QuizApp

class ResultsViewControllerTests: XCTestCase {
    
    func test_viewDidLoad_renderSummary() {
        XCTAssertEqual(makeSUT(summary: "a summary").headerLabel.text, "a summary")
    }
    
    func test_viewDidLoad_withoutAnswers_doesNotRenderAnswers() {
    }
    
    func test_viewDidLoad_rendersAnswers() {
        XCTAssertEqual(makeSUT().tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_rendersCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1", isCorrect: true)
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_rendersCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1", isCorrect: false)
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
    }
    
    // MARK: Helpers
    
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewContoller {
        let sut = ResultsViewContoller(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    func makeDummyAnswer() -> PresentableAnswer {
        PresentableAnswer(question: "Q1", answer: "A1", isCorrect: false)
    }
    
    func makeAnswer(question: String = "", answer: String = "", isCorrect: Bool) -> PresentableAnswer {
        PresentableAnswer(question: question, answer: answer, isCorrect: isCorrect)
    }
}
