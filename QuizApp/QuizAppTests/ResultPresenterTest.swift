//
// Created on 2023/1/12.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

class ResultPresenterTest: XCTestCase {
    
    func test_summary_withTwoQuestionsAndScoreOne_returnSummary() {
        let answers = [Question.singleAnswer("Q1"): ["A1"], Question.multipleAnswer("Q2"): ["A2"]]
        let result = Result.make(answers: answers, score: 1)
        let sut = ResultPresenter(result: result, correctAnswers: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct.")
    }
    
    func test_presentableAnswers_withoutQuestion_isEmpty() {
        let answers = Dictionary<Question<String>, [String]>()
        let result = Result.make(answers: answers, score: 1)
        let sut = ResultPresenter(result: result, correctAnswers: [:])
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswer = [Question.singleAnswer("Q1"): ["A2"]]
        let result = Result.make(answers: answers, score: 0)
        let sut = ResultPresenter(result: result, correctAnswers: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let correctAnswer = [Question.multipleAnswer("Q1"): ["A2", "A3"]]
        let result = Result.make(answers: answers, score: 0)
        let sut = ResultPresenter(result: result, correctAnswers: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A4")
    }
}
