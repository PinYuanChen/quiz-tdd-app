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
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            let vc = QuestionViewController(question: value, options: options[question]!, selection: answerCallback)
            return vc
        default:
            return .init()
        }
    }
    
    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return .init()
    }
}
