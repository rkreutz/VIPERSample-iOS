@testable import SBTask
import XCTest

class LoginPresenterTests: XCTestCase {
    var presenter: LoginPresenter!
    var router: MockLoginRouter!
    var view: MockLoginView!
    var interactor: MockLoginInteractor!

    override func setUp() {
        view = MockLoginView()
        router = MockLoginRouter()
        interactor = MockLoginInteractor()
        presenter = LoginPresenter(interface: view, interactor: interactor, router: router)
        interactor.presenter = presenter
    }

    func test_OnLoginButtonPress_NavigateToPhotos() {
        presenter.didPressLoginButton()
        
        XCTAssertTrue(router.navigateToPhotosCalled)
    }

    func test_OnLoginButtonPress_InvalidEmail() {
        interactor.loginError = .invalidEmail
        presenter.didPressLoginButton()

        XCTAssertTrue(view.showInvalidEmailCalled)
    }

    func test_OnLoginButtonPress_InvalidPassword() {
        interactor.loginError = .invalidPassword
        presenter.didPressLoginButton()

        XCTAssertTrue(view.showInvalidPasswordCalled)
    }
}
