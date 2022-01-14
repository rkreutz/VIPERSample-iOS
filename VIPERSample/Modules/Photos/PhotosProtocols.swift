// Protocols: Define interactions between components of the VIPER module.

import Foundation
import class UIKit.UIImage

// MARK: Router
/// Navigation
protocol PhotosRouterProtocol: AnyObject {
}

// MARK: - Presenter
/// ViewController -> Presenter
protocol PhotosPresenterProtocol: AnyObject {
    var interactor: PhotosInteractorInputProtocol? { get set }
    var numberOfPhotos: Int { get }

    func viewDidLoad()
    func photo(at index: Int) -> Photo
}

// MARK: - Interactor
/// Presenter -> Interactor
protocol PhotosInteractorInputProtocol: AnyObject {
    var presenter: PhotosInteractorOutputProtocol? { get set }
    
    func loadPhotos()
}

/// Interactor -> Presenter
protocol PhotosInteractorOutputProtocol: AnyObject {
    func didFinishLoadingPhotos(_ photos: [Photo])
    func didLoadThumbnail(photoIndex: Int, thumbnail: Data)
}

// MARK: - View
/// Presenter -> ViewController
protocol PhotosViewProtocol: AnyObject {
    var presenter: PhotosPresenterProtocol? { get set }
    
    func refreshPhotos()
    func refreshPhoto(at index: Int)
}
