//
// Created on 2023/1/7.
//

import UIKit
import XCTest
@testable import QuizApp

final class QuestionViewControllerTest: XCTestCase {

    func test_viewDidLoad_renderQuestionHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1", options: ["A1"]).headerLabel.text, "Q1")
    }

    func test_viewDidLoad_rendersOptions() {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_rendersOptionsText() {
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }
    
    func test_optionSelected_withSingleOption_notifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionDeselected_withSingleOption_doesNotNotifyDelegateWithEmptySelection() {
        var callBackCount = 0
        
        let sut = makeSUT(options: ["A1", "A2"]) { _ in callBackCount += 1
        }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callBackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callBackCount, 1)
    }
    
    func test_optionSelected_withTwoOptions_notifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegateSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
    }
    
    func test_optionDeselected_withMultipleSelectionEnabled_notifiesDelegateSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselect(row: 0)
        
        XCTAssertEqual(receivedAnswer, [])
    }
    
    // MARK: Helpers
    func makeSUT(question: String = "",
                 options: [String],
                 selection: @escaping ([String]) -> Void = { _ in}) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)

        _ = sut.view
        return sut
    }
}
