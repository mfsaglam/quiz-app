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
        delegate: QuizDelegateToRouterAdapter(router, correctAnswers)
    )
    flow.start()
    return Game(flow: flow)
}

@available(*, deprecated) // Add a deprecated message
private class QuizDelegateToRouterAdapter<R: Router>: QuizDelegate where R.Answer: Equatable {
    private let router: R
    private let correctAnswers: [R.Question: R.Answer]
    
    init(_ router: R, _ correctAnswers: [R.Question: R.Answer]) {
        self.router = router
        self.correctAnswers = correctAnswers
    }
    
    func answer(
        for question: R.Question,
        completion: @escaping (R.Answer)-> Void
    ) {
        router.routeTo(question: question, answerCallback: completion)
    }
    
    func didCompleteQuiz(
        withAnswers answers: [(question: R.Question, answer: R.Answer)]
    ) {
        let answersDictionary = answers.reduce([R.Question: R.Answer]()) { acc, tuple in
            var acc = acc
            acc[tuple.question] = tuple.answer
            return acc
        }
        
        let score = scoring(answersDictionary, correctAnswers: correctAnswers)
        
        let result = Result(
            answers: answersDictionary,
            score: score
        )
        router.routeTo(result: result)
    }
        
    private func scoring<Question, Answer: Equatable>(
        _ answers: [Question: Answer],
        correctAnswers: [Question: Answer]
    ) -> Int {
        return answers.reduce(0) { (score, tuple) in
            return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
        }
    }
}
