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
    
    /// thats what it does, it handle's the `Result` and its client's responsibility to handle it.
    func handle(question: Question, answerCallback: @escaping (Answer) -> Void)
    func handle(result: Result<Question, Answer>) /// Result can be an associatedtype too. it is leaking the implementation to the clients. Migrate first, and start changing it.
}

@available(*, deprecated) // TODO: Add deprecated message
public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}
