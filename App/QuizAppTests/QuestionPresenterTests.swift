//
//  QuestionPresenterTests.swift
//  QuizAppTests
//
//  Created by Fatih Sağlam on 10.09.2023.
//

import XCTest
@testable import QuizApp

class QuestionPresenterTests: XCTestCase {
    
    let question1 = Question.singleAnswer("Q1")
    let question2 = Question.multipleAnswer("Q2")
    
    func test_title_forFirstQuestion_formatsTitleForIndex() {
        let sut = QuestionPresenter(
            questions: [question1],
            question: question1
        )
        
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion_formatsTitleForIndex() {
        let sut = QuestionPresenter(
            questions: [question1, question2],
            question: question2
        )
        
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forUnexistentQuestion_isEmpty() {

        let sut = QuestionPresenter(
            questions: [],
            question: Question.singleAnswer("Q1")
        )
        
        XCTAssertEqual(sut.title, "")
    }
}
