//
// Created on 2023/1/11.
//

import Foundation
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    func test_questionViewController_createsController() {
        let sut = iOSViewControllerFactory()
        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: { _ in }) as QuestionViewController
        XCTAssertNotNil(controller)
    }
    
}
