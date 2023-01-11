//
// Created on 2023/1/11.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
        return .init()
    }
    
    func resultViewController(for result: QuizEngine.Result<Question<String>, String>) -> UIViewController {
        return .init()
    }
}
