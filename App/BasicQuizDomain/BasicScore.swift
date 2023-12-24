//
//  BasicScore.swift
//  QuizApp
//
//  Created by Fatih Sağlam on 27.11.2023.
//

import Foundation

public final class BasicScore {
    public static func score<T: Equatable>(for answers: [T], comparingTo correctAnswers: [T]) -> Int {
        zip(answers, correctAnswers).reduce(0) { score, tuple in
            return score + (tuple.0 == tuple.1 ? 1 : 0)
        }
    }
}
