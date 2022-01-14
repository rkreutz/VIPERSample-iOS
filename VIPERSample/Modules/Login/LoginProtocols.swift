// Protocols: Define interactions between components of the VIPER module.

import Foundation
import struct UIKit.CGRect

// MARK: - View
/// Presenter -> ViewController
protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }

    func keyboardFrameDidChange(_ frame: CGRect, timeInterval: TimeInterval)
    func showInvalidEmail()
    func showInvalidPassword()
}

// MARK: - Presenter
/// ViewController -> Presenter
protocol LoginPresenterProtocol: AnyObject {
    var interactor: LoginInteractorInputProtocol? { get set }
    
    func viewDidAppear()
    func viewDidDisappear()
    func didPressLoginButton()
    func didUpdateEmail(_ email: String)
    func didUpdatePassword(_ password: String)
}

// MARK: - Interactor
/// Presenter -> Interactor
protocol LoginInteractorInputProtocol: AnyObject {
    var presenter: LoginInteractorOutputProtocol? { get set }

    func login(email: String, password: String)
}

enum LoginInteractorError: Error {
    case invalidEmail
    case invalidPassword
}

/// Interactor -> Presenter
protocol LoginInteractorOutputProtocol: AnyObject {
    func userAuthentication(_ result: Result<Void, LoginInteractorError>)
}

// MARK: Router
/// Navigation
protocol LoginRouterProtocol: AnyObject {
    func navigateToPhotos()
}
