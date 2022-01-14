import UIKit

final class KeyboardFrameObserver {

    private let keyboardFrameHandler: ((CGRect, TimeInterval) -> Void)

    init(keyboardFrameHandler: @escaping ((CGRect, TimeInterval) -> Void)) {

        self.keyboardFrameHandler = keyboardFrameHandler
    }

    func startObservingKeyboardFrame() {

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardNotification(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }

    func stopObservingKeyboardFrame() {

        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillChangeFrameNotification,
                                                  object: nil)
    }

    @objc
    private func keyboardNotification(_ sender: Notification) {

        guard
            let newFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let animationDuration = sender.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }

        keyboardFrameHandler(newFrame, animationDuration)
    }
}
