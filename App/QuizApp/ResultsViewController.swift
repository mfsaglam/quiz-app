//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Fatih Sağlam on 28.08.2023.
//

import UIKit

struct PresentableAnswer {
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    
}

class WrongAnswerCell: UITableViewCell {
    
}

class ResultsViewContoller: UIViewController, UITableViewDataSource {
    
    var headerLabel: UILabel = UILabel()
    var tableView = UITableView()
    private var summary = ""
    private var answers = [PresentableAnswer]()
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureUI()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
    }
    
    private func configureUI() {
        view.addSubview(headerLabel)
        view.addSubview(tableView)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = summary
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        return answer.isCorrect ? CorrectAnswerCell() : WrongAnswerCell()
    }
}
