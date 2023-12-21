//
//  BasicQuizBuilderTest.swift
//  QuizAppTests
//
//  Created by Fatih Sağlam on 21.12.2023.
//

import XCTest

struct BasicQuiz {

}

struct BasicQuizBuilder {
    func build() -> BasicQuiz? {
        nil
    }
}

class BasicQuizBuilderTest: XCTestCase {

    func test_empty() {
        let sut = BasicQuizBuilder()

        XCTAssertNil(sut.build())
    }

}
