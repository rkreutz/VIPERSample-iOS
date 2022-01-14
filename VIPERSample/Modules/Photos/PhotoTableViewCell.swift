import UIKit

final class PhotoTableViewCell: UITableViewCell {

    static let nib = UINib(nibName: "PhotoTableViewCell", bundle: nil)
    static let reuseIdentifier = "PhotoTableViewCell"

    @IBOutlet private var containerView: UIView! {
        didSet {
            if #available(iOS 13.0, *) {
                containerView.layer.cornerCurve = .continuous
            }
            containerView.layer.cornerRadius = 8
        }
    }
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var thumbnailView: UIImageView! {
        didSet {
            if #available(iOS 13.0, *) {
                containerView.layer.cornerCurve = .continuous
            }
            containerView.layer.cornerRadius = 8
        }
    }

    func update(title: String) {
        titleLabel.text = title
    }

    func update(thumbnail: UIImage?) {
        thumbnailView.image = thumbnail
    }
}
