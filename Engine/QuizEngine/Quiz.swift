//
//  Quiz.swift
//  QuizEngine
//
//  Created by Fatih Sağlam on 14.11.2023.
//

import Foundation

public final class Quiz {
    private let flow: Any
    
    private init(flow: Any) {
        self.flow = flow
    }
    
    public static func start<Question: Hashable, Answer: Equatable, Delegate: QuizDelegate>(
        questions: [Question],
        delegate: Delegate,
        correctAnswers: [Question: Answer]
    ) -> Quiz where Delegate.Question == Question, Delegate.Answer == Answer {
        let flow = Flow(questions: questions, delegate: delegate, scoring: { scoring($0, correctAnswers: correctAnswers ) })
        flow.start()
        return Quiz(flow: flow)
    }
}
