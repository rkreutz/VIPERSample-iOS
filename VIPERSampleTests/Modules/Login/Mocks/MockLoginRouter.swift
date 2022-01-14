@testable import SBTask

class MockLoginRouter: LoginRouterProtocol {
    var navigateToPhotosCalled = false
    
    func navigateToPhotos() {
        navigateToPhotosCalled = true
    }
}
