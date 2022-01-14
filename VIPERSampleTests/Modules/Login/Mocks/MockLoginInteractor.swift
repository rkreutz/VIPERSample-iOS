@testable import SBTask

final class MockLoginInteractor: LoginInteractorInputProtocol {
    var loginError: LoginInteractorError? = nil
    var presenter: LoginInteractorOutputProtocol?

    func login(email: String, password: String) {
        if let error = loginError {
            presenter?.userAuthentication(.failure(error))
        } else {
            presenter?.userAuthentication(.success(()))
        }
    }
}
