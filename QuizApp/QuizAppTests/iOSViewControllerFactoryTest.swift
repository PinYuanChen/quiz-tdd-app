//
// Created on 2023/1/11.
//

import UIKit
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    let options = ["A1", "A2"]
    
    func test_questionViewController_createsControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: "Q1").question, "Q1")
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
    func makeSUT(options: Dictionary<Question<String>, [String]>) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }
    
    func makeQuestionController(question: String = "") -> QuestionViewController {
        let q = Question.singleAnswer(question)
        return makeSUT(options: [q: options]).questionViewController(for: q) { _ in } as! QuestionViewController
    }
}
