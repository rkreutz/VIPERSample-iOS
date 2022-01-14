// Presenter: Contains view logic for preparing content for display (as received from the Interactor) and for reacting
// to user inputs (by requesting new data from the Interactor).

import Foundation

final class PhotosPresenter: PhotosPresenterProtocol {
    weak private var view: PhotosViewProtocol?
    var interactor: PhotosInteractorInputProtocol?
    private let router: PhotosRouterProtocol

    var numberOfPhotos: Int { photos.count }

    let lock = NSRecursiveLock()
    private var photos: [Photo] = []

    init(interface: PhotosViewProtocol, interactor: PhotosInteractorInputProtocol?, router: PhotosRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        interactor?.loadPhotos()
    }

    func photo(at index: Int) -> Photo {
        photos[index]
    }
}

extension PhotosPresenter: PhotosInteractorOutputProtocol {
    func didFinishLoadingPhotos(_ photos: [Photo]) {
        self.photos = photos
        DispatchQueue.main.sync { view?.refreshPhotos() }
    }

    func didLoadThumbnail(photoIndex: Int, thumbnail: Data) {
        lock.lock()
        photos[photoIndex].thumbnail = thumbnail
        lock.unlock()
        DispatchQueue.main.sync { view?.refreshPhoto(at: photoIndex) }
    }
}
