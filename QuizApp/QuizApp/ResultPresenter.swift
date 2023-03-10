//
// Created on 2023/1/12.
//

import Foundation
import QuizEngine

struct ResultPresenter {
    let result: Result<Question<String>, [String]>
    let questions: [Question<String>]
    let correctAnswers: Dictionary<Question<String>, [String]>
    
    var summary: String {
        return "You got \(result.score)/\(result.answers.count) correct."
    }
    
    var presentableAnswers: [PresentableAnswer] {
        return questions.map { question in
            
            guard let userAnswer = result.answers[question],
                  let correctAnswer = correctAnswers[question] else {
                fatalError("Couldn't find correct answer for question: \(question)")
            }
            
            return presentableAnswers(question, userAnswer, correctAnswer)
        }
    }
    
    private func presentableAnswers(_ question: Question<String>, _ userAnswer: [String], _ correctAnswer: [String]) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let value),
                .multipleAnswer(let value):
            return PresentableAnswer(
                question: value,
                answer: formattedAnswer(correctAnswer),
                wrongAnswer: formattedWrongAnswer(userAnswer, correctAnswer))
        }
    }
    
    private func formattedAnswer(_ answer: [String]) -> String {
        return answer.joined(separator: ", ")
    }
    
    private func formattedWrongAnswer(_ userAnswer: [String], _ correctAnswer: [String]) -> String? {
        return correctAnswer == userAnswer ? nil : formattedAnswer(userAnswer)
    }
}
