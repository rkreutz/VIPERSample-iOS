@testable import SBTask
import XCTest

final class LoginInteractorTests: XCTestCase {

    var interactor: LoginInteractor!
    var presenter: MockLoginInteractorOutput!

    override func setUp() {
        presenter = MockLoginInteractorOutput()
        interactor = LoginInteractor()
        interactor.presenter = presenter
    }

    func test_OnLogin_WithValidEmail() {
        interactor.login(email: "rkreutz.ie@gmail.com", password: "mySecretPassword")

        XCTAssertEventually {

            guard case .success = self.presenter.userAuthenticationResult else { return false }
            return true
        }
    }

    func test_OnLogin_WithInvalidEmail() {
        interactor.login(email: "notAnEmail", password: "mySecretPassword")

        XCTAssertEventually {

            guard case .failure(.invalidEmail) = self.presenter.userAuthenticationResult else { return false }
            return true
        }
    }

    func test_OnLogin_WithInvalidPassword() {
        interactor.login(email: "rkreutz.ie@gmail.com", password: "")

        XCTAssertEventually {

            guard case .failure(.invalidPassword) = self.presenter.userAuthenticationResult else { return false }
            return true
        }
    }
}
