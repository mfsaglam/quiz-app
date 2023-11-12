//
//  Game.swift
//  QuizEngine
//
//  Created by Fatih Sağlam on 1.09.2023.
//

import Foundation

/// We deprecate these because everything is `public` might be used by a client. So we need new `api`s.
@available(*, deprecated) // TODO: Add a deprecated message
public class Game<Question: Hashable, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    private let flow: Flow<R>

    init(flow: Flow<R>) {
        self.flow = flow
    }
}

@available(*, deprecated) // TODO: Add deprecated message
public func startGame<Question: Hashable, Answer: Equatable, R: Router>(questions: [Question], router: R, correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: { scoring($0, correctAnswers: correctAnswers ) })
    flow.start()
    return Game(flow: flow)
}

// TODO: What should we do with this function? (it is a leaky detail)
private func scoring <Question: Hashable, Answer: Equatable>(
    _ answers: [Question: Answer],
    correctAnswers: [Question: Answer]
) -> Int {
    return answers.reduce(0) { (score, tuple) in
        return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
    }
}
