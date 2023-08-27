//
//  QuestionViewControllerTests.swift
//  QuizAppTests
//
//  Created by Fatih Sağlam on 27.08.2023.
//

import XCTest
@testable import QuizApp

class QuestionViewControllerTests: XCTestCase {
    
    func test_viewDidLoad_rendersHeaderText() {
        let sut = QuestionViewController(question: "Q1", options: [])
        
        _ = sut.view
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad__withNoOptions_rendersZeroOptions() {
        let sut = QuestionViewController(question: "Q1", options: [])
        
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad__withOneOption_rendersOneOption() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad__withOneOption_rendersOneOptionText() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        
        _ = sut.view
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
}
