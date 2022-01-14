// Module Builder: Responsible for building the VIPER module by using dependency injection for all external services.

import UIKit

final class PhotosModule {
    func build() -> UIViewController {
        let view = UIStoryboard(name: "Photos", bundle: nil).instantiateInitialViewController() as! PhotosViewController
        let router = PhotosRouter()
        let interactor = PhotosInteractor(dataLoader: URLSessionDataLoader.shared, imageLoader: ImageLoader.shared)
        let presenter = PhotosPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        router.viewController = view
        interactor.presenter = presenter

        return view
    }
}
