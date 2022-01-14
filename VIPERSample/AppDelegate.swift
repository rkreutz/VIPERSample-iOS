import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        launchLoginScreen()
        return true
    }
}

extension AppDelegate {
    private func launchLoginScreen() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let login = LoginModule().build()
        let navigation = UINavigationController(rootViewController: login)
        if #available(iOS 13.0, *) {
            navigation.navigationBar.tintColor = UIColor.label
        }
        window!.rootViewController = navigation
        window!.makeKeyAndVisible()
    }
}
