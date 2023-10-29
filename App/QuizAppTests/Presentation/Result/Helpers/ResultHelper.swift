//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by Fatih Sağlam on 10.09.2023.
//

import QuizEngine

extension Result: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
    
    public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        lhs.score == rhs.score
    }
}
