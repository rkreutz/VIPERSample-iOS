// Interactor: Responsible for retrieving data from the model layer, it is independent of the user interface.

import Foundation

final class LoginInteractor: LoginInteractorInputProtocol {
    weak var presenter: LoginInteractorOutputProtocol?

    func login(email: String, password: String) {
        DispatchQueue.global().async { [weak presenter] in
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            guard emailTest.evaluate(with: email) else {
                presenter?.userAuthentication(.failure(.invalidEmail))
                return
            }
            guard !password.isEmpty else {
                presenter?.userAuthentication(.failure(.invalidPassword))
                return
            }

            presenter?.userAuthentication(.success(()))
        }
    }
}
