//
// Created on 2023/1/10.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, facotry: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = facotry
    }
    
    func routeTo(question: Question<String>, answerCallback: @escaping ([String]) -> Void) {
        show(factory.questionViewController(for: question, answerCallback: answerCallback))
    }
    
    func routeTo(result: Result<Question<String>, [String]>) {
        show(factory.resultViewController(for: result))
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
