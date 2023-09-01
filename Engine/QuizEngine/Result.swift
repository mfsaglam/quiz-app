//
//  Result.swift
//  QuizEngine
//
//  Created by Fatih Sağlam on 1.09.2023.
//

import Foundation

struct Result<Question: Hashable, Answer> {
    let answers: [Question: Answer]
    let score: Int
}
