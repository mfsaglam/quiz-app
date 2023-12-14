//
//  QuizApp.swift
//  QuizApp
//
//  Created by Fatih Sağlam on 14.12.2023.
//

import SwiftUI
import QuizEngine

class QuizAppStore {
    var quiz: Quiz?
}

@main
struct QuizApp: App {
    let appStore = QuizAppStore()
    @StateObject var navigationStore = QuizNavigationStore()

    var body: some Scene {
        WindowGroup {
            QuizNavigationView(store: navigationStore)
                .onAppear {
                    startNewQuiz()
                }
        }
    }

    private func startNewQuiz() {
        let adapter = iOSSwiftUINavigationAdapter(
            navigation: navigationStore,
            options: options,
            correctAnswers: correctAnswers,
            playAgain: startNewQuiz)

        appStore.quiz = Quiz.start(questions: questions, delegate: adapter)
    }
}
