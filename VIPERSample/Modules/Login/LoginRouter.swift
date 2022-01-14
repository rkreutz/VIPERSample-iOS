// Router: Contains navigation logic for describing which screens are shown in which order.

import UIKit

final class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToPhotos() {
        let photos = PhotosModule().build()
        viewController?.navigationController?.pushViewController(photos, animated: true)
    }
}
