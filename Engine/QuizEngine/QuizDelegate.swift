//
//  Router.swift
//  QuizEngine
//
//  Created by Fatih Sağlam on 1.09.2023.
//

import Foundation

/// GOAL: Migrate usage of the deprevated `Router` with the new `QuizDelegate` protocol without breaking clients.

/// Used by the QuizEngine's Flow to delegate handling the `nextQuestion` and handling the `Result`.
/// It is called QuizDelegate because clients doesn't know about the `Flow` outside the `Engine`.
/// it is not called QuizGameDelegate, because clients should decide if they want to Gamify it or just make a survey type of a quiz.
public protocol QuizDelegate {
    // TODO: Remove Hashable constraint and make the result type Generic.
    associatedtype Question: Hashable
    associatedtype Answer
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    func handle(result: Result<Question, Answer>)

    ///func answer(for question: Question, completion: @escaping (Answer) -> Void) /// `DataSource` method
    ///func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)]) /// `Delegate` method
}
