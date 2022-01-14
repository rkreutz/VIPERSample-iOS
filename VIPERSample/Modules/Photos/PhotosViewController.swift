// View: Displays what the Presenter tells it to display and relays user input back to the Presenter.

import UIKit

final class PhotosViewController: UIViewController, PhotosViewProtocol {
    var presenter: PhotosPresenterProtocol?

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.register(PhotoTableViewCell.nib, forCellReuseIdentifier: PhotoTableViewCell.reuseIdentifier)
            tableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        presenter?.viewDidLoad()
    }

    func refreshPhotos() {
        tableView.reloadData()
    }

    func refreshPhoto(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        if tableView.indexPathsForVisibleRows?.contains(indexPath) == true {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension PhotosViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard section == 0 else { return 0 }
        return presenter?.numberOfPhotos ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.reuseIdentifier, for: indexPath)
        guard let photoCell = cell as? PhotoTableViewCell else { fatalError("Dequeued cell is not PhotoTableViewCell") }

        if let presenter = presenter {
            photoCell.update(title: presenter.photo(at: indexPath.row).title)
            photoCell.update(thumbnail: presenter.photo(at: indexPath.row).thumbnail.flatMap(UIImage.init(data:)))
        }

        return photoCell
    }
}
