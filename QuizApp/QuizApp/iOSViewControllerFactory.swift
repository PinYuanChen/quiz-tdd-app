//
// Created on 2023/1/11.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    
    private let options: Dictionary<Question<String>, [String]>
    
    init(options: Dictionary<Question<String>, [String]>) {
        self.options = options
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
        return QuestionViewController(question: "", options: options[question]!) { _ in }
    }
    
    func resultViewController(for result: Result<Question<String>, String>) -> UIViewController {
        return .init()
    }
}
