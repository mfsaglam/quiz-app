//
//  Result.swift
//  QuizEngine
//
//  Created by Fatih Sağlam on 1.09.2023.
//

import Foundation

/// Deprecate `Result`
public struct Result<Question: Hashable, Answer> {
    public var answers: [Question: Answer]
    public var score: Int
    
    public init(answers: [Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
}
