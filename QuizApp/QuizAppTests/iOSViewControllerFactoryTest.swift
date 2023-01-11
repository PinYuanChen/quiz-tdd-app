//
// Created on 2023/1/11.
//

import UIKit
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    let question = Question.singleAnswer("Q1")
    let options = ["A1", "A2"]
    
    func test_questionViewController_createsControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController().question, "Q1")
    }
    
    func test_questionViewController_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController().options, options)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        let controller = makeQuestionController()
        _ = controller.view // load view
        
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: Helpers
    func makeSUT() -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: [question: options])
    }
    
    func makeQuestionController() -> QuestionViewController {
        return makeSUT().questionViewController(for: question) { _ in } as! QuestionViewController
    }
}
