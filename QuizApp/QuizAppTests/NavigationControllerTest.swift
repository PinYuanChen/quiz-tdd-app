//
// Created on 2023/1/10.
//

import UIKit
import XCTest
@testable import QuizEngine
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, facotry: self.factory)
    }()
    
    func test_routeToQuestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: Question.singleAnswer("Q1"), with: viewController)
        factory.stub(question: Question.singleAnswer("Q2"), with: secondViewController)
        
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestions_presentsQuestionControllerWithRightCallback() {
        var callBackWasFired = false
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in callBackWasFired = true })
        factory.answerCallback[Question.singleAnswer("Q1")]!("anything")
        
        XCTAssertTrue(callBackWasFired)
    }
    
    func test_routeToResult_showsResultController() {
        let viewController = UIViewController()
        let result = Result.make(answers: [Question.singleAnswer("Q1"): "A1"], score: 10)
        factory.stub(result: result, with: viewController)
        
        sut.routeTo(result: result)
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }
    
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = Dictionary<Question<String>, UIViewController>()
        private var stubbedResults = Dictionary<Result<Question<String>, String>, UIViewController>()
        var answerCallback = Dictionary<Question<String>, (String) -> Void>()
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func stub(result: Result<Question<String>, String>, with viewController: UIViewController) {
            stubbedResults[result] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? .init()
        }
        
        func resultViewController(for result: Result<Question<String>, String>) -> UIViewController {
            return stubbedResults[result] ?? .init()
        }
    }
}

extension Result: Hashable {

    static func make(answers: [Question: Answer] = [:], score: Int = 0) -> Result<Question, Answer> {
        return Result(answers: answers, score: score)
    }
    
    public var hashValue: Int {
        return 1
    }
    
    public static func == (lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
