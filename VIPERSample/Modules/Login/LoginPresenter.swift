// Presenter: Contains view logic for preparing content for display (as received from the Interactor) and for reacting
// to user inputs (by requesting new data from the Interactor).

import Foundation

final class LoginPresenter: LoginPresenterProtocol {
    weak private var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    private let router: LoginRouterProtocol
    private var email: String = ""
    private var password: String = ""
    private lazy var keyboardFrameObserver = KeyboardFrameObserver { [weak view] in view?.keyboardFrameDidChange($0, timeInterval: $1) }

    init(interface: LoginViewProtocol, interactor: LoginInteractorInputProtocol?, router: LoginRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func viewDidAppear() {
        keyboardFrameObserver.startObservingKeyboardFrame()
    }

    func viewDidDisappear() {
        keyboardFrameObserver.stopObservingKeyboardFrame()
    }
    
    func didPressLoginButton() {
        interactor?.login(email: email, password: password)
    }

    func didUpdateEmail(_ email: String) {
        self.email = email
    }

    func didUpdatePassword(_ password: String) {
        self.password = password
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func userAuthentication(_ result: Result<Void, LoginInteractorError>) {

        DispatchQueue.main.sync {
            switch result {
            case .success:
                router.navigateToPhotos()

            case .failure(.invalidEmail):
                view?.showInvalidEmail()

            case .failure(.invalidPassword):
                view?.showInvalidPassword()
            }
        }
    }
}
