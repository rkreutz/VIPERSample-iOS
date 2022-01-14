@testable import SBTask
import Foundation
import struct UIKit.CGRect

final class MockLoginView: LoginViewProtocol {

    var showInvalidEmailCalled = false
    var showInvalidPasswordCalled = false
    var presenter: LoginPresenterProtocol?

    func keyboardFrameDidChange(_ frame: CGRect, timeInterval: TimeInterval) {}
    
    func showInvalidEmail() {
        showInvalidEmailCalled = true
    }

    func showInvalidPassword() {
        showInvalidPasswordCalled = true
    }
}
