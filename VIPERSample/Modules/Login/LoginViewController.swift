
// View: Displays what the Presenter tells it to display and relays user input back to the Presenter.

import UIKit

final class LoginViewController: UIViewController, LoginViewProtocol {

    var presenter: LoginPresenterProtocol?

    @IBOutlet private var emailField: TextField! {
        didSet {
            emailField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    @IBOutlet private var passwordField: TextField! {
        didSet {
            passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear()
    }

    func keyboardFrameDidChange(_ frame: CGRect, timeInterval: TimeInterval) {
        let intersectingFrame = view.layoutMarginsGuide.layoutFrame.intersection(frame)
        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: intersectingFrame.height, right: 0)

        UIView.animate(
            withDuration: timeInterval,
            delay: 0,
            options: [],
            animations: view.layoutIfNeeded
        )
    }

    func showInvalidEmail() {
        let alert = UIAlertController(
            title: "Invalid Email",
            message: "The provided email is invalid, please use a different email.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func showInvalidPassword() {
        let alert = UIAlertController(
            title: "Invalid Password",
            message: "The password can't be empty.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case emailField:
            presenter?.didUpdateEmail(textField.text ?? "")

        case passwordField:
            presenter?.didUpdatePassword(textField.text ?? "")

        default:
            fatalError("No matching text field")
        }
    }

    @IBAction private func login() {

        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        presenter?.didPressLoginButton()
    }
}
