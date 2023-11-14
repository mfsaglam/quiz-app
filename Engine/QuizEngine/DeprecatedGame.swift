//
//  Game.swift
//  QuizEngine
//
//  Created by Fatih Sağlam on 1.09.2023.
//

import Foundation

@available(*, deprecated) // TODO: Add deprecated message
public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}

/// We deprecate these because everything is `public` might be used by a client. So we need new `api`s.
@available(*, deprecated) // TODO: Add a deprecated message
public class Game<Question: Hashable, Answer, R: Router> { /// Be careful with those generic constraints in public APIs
    private let flow: Any

    init(flow: Any) {
        self.flow = flow
    }
}

@available(*, deprecated) // TODO: Add deprecated message
public func startGame<Question: Hashable, Answer: Equatable, R: Router>(
    questions: [Question],
    router: R,
    correctAnswers: [Question: Answer]
) -> Game<Question, Answer, R>  where R.Question == Question, R.Answer == Answer {
    let flow = Flow(
        questions: questions,
        delegate: QuizDelegateToRouterAdapter(router),
        scoring: { scoring($0, correctAnswers: correctAnswers) }
    )
    flow.start()
    return Game(flow: flow)
}

@available(*, deprecated) // Add a deprecated message
private class QuizDelegateToRouterAdapter<R: Router>: QuizDelegate {
    private let router: R
    
    init(_ router: R) {
        self.router = router
    }
    
    func handle(
        question: R.Question,
        answerCallback: @escaping (R.Answer)-> Void
    ) {
        router.routeTo(question: question, answerCallback: answerCallback)
    }
    
    func handle(
        result: Result<R.Question, R.Answer>
    ) {
        router.routeTo(result: result)
    }
}
