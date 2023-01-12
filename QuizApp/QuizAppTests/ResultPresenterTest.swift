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
        let sut = ResultPresenter(result: result, questions: [Question.singleAnswer("Q1"), Question.multipleAnswer("Q2")], correctAnswers: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct.")
    }
    
    func test_presentableAnswers_withoutQuestion_isEmpty() {
        let answers = Dictionary<Question<String>, [String]>()
        let result = Result.make(answers: answers, score: 1)
        let sut = ResultPresenter(result: result, questions: [], correctAnswers: [:])
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswer = [Question.singleAnswer("Q1"): ["A2"]]
        let result = Result.make(answers: answers, score: 0)
        
        let sut = ResultPresenter(result: result, questions: [Question.singleAnswer("Q1")], correctAnswers: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let correctAnswer = [Question.multipleAnswer("Q1"): ["A2", "A3"]]
        let result = Result.make(answers: answers, score: 0)
        let sut = ResultPresenter(result: result, questions: [Question.multipleAnswer("Q1")], correctAnswers: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswers_withRightSingleAnswer_mapsAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A1"]]
        let result = Result.make(answers: answers, score: 1)
        
        let sut = ResultPresenter(result: result, questions: [Question.singleAnswer("Q1")], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
    
    func test_presentableAnswers_withRightMultipleAnswer_mapsAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let correctAnswer = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let result = Result.make(answers: answers, score: 0)
        let sut = ResultPresenter(result: result, questions: [Question.multipleAnswer("Q1")], correctAnswers: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
    
    func test_presentableAnswers_withTwoQuestions_mapsOrderedAnswer() {
        let answers = [Question.multipleAnswer("Q2"): ["A2"], Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let correctAnswer = [Question.multipleAnswer("Q2"): ["A2"], Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let orderedQuestions = [Question.multipleAnswer("Q1"), Question.multipleAnswer("Q2")]
        let result = Result.make(answers: answers, score: 0)
        let sut = ResultPresenter(result: result, questions: orderedQuestions, correctAnswers: correctAnswer)

        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)

        XCTAssertEqual(sut.presentableAnswers.last!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.last!.answer, "A2")
        XCTAssertNil(sut.presentableAnswers.last!.wrongAnswer)
    }
}
