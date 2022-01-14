// Module Builder: Responsible for building the VIPER module by using dependency injection for all external services.

import UIKit

final class LoginModule {
    func build() -> UIViewController {
        let view = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! LoginViewController
        view.navigationItem.backButtonTitle = ""
        let router = LoginRouter()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        router.viewController = view
        interactor.presenter = presenter

        return view
    }
}
