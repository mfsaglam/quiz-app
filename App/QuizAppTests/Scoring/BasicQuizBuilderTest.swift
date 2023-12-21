//
//  BasicQuizBuilderTest.swift
//  QuizAppTests
//
//  Created by Fatih Sağlam on 21.12.2023.
//

import XCTest
import QuizEngine

struct BasicQuiz {
    let questions: [Question<String>]
}

struct BasicQuizBuilder {
    private let questions: [Question<String>]
    
    init(singleAnswerQuestion: String) {
        questions = [.singleAnswer(singleAnswerQuestion)]
    }
    
    func build() -> BasicQuiz {
        BasicQuiz(questions: questions)
    }
}

class BasicQuizBuilderTest: XCTestCase {
    
    func test_initWithSingleAnswerQuestion() {
        let sut = BasicQuizBuilder(singleAnswerQuestion: "q1")
        
        XCTAssertEqual(sut.build().questions, [.singleAnswer("q1")])
    }
    
}
