@testable import SBTask

final class MockLoginInteractorOutput: LoginInteractorOutputProtocol {

    var userAuthenticationResult: Result<Void, LoginInteractorError>?
    func userAuthentication(_ result: Result<Void, LoginInteractorError>) {
        userAuthenticationResult = result
    }
}
