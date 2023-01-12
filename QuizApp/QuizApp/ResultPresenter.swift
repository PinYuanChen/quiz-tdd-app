//
// Created on 2023/1/12.
//

import Foundation
import QuizEngine

struct ResultPresenter {
    let result: Result<Question<String>, [String]>
    let correctAnswers: Dictionary<Question<String>, [String]>
    
    var summary: String {
        return "You got \(result.score)/\(result.answers.count) correct."
    }
    
    var presentableAnswers: [PresentableAnswer] {
        return result.answers.map { (question, userAnswers) in
            switch question {
            case .singleAnswer(let value),
                    .multipleAnswer(let value):
                return PresentableAnswer(question: value, answer: correctAnswers[question]!.joined(separator: ", "), wrongAnswer: userAnswers.joined(separator: ", "))
            }
        }
    }
}
