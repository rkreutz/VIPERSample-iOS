import UIKit

final class TextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        configureBorder()
        configureColor()
        configureEvents()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect { bounds.insetBy(dx: 8, dy: 4) }

    override func editingRect(forBounds bounds: CGRect) -> CGRect { bounds.insetBy(dx: 8, dy: 4) }

    private func configureBorder() {
        borderStyle = .none
        layer.cornerRadius = 8
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
        layer.borderWidth = 1
    }

    private func configureColor() {
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
            layer.borderColor = UIColor.secondarySystemBackground.cgColor
        } else {
            backgroundColor = .gray
            layer.borderColor = UIColor.gray.cgColor
        }
    }

    private func configureEvents() {
        addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
        addTarget(self, action: #selector(didEndEditing), for: .editingDidEndOnExit)
    }

    @objc private func didBeginEditing() {
        layer.borderColor = tintColor.cgColor
    }

    @objc private func didEndEditing() {
        if #available(iOS 13.0, *) {
            layer.borderColor = UIColor.secondarySystemBackground.cgColor
        } else {
            layer.borderColor = UIColor.gray.cgColor
        }
    }
}
