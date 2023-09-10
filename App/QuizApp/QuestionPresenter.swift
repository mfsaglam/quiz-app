//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by Fatih Sağlam on 10.09.2023.
//

import Foundation

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>
    
    var title: String {
        guard let index = questions.firstIndex(of: question) else { return "" }
        return "Question #\(index + 1)"
    }
}
