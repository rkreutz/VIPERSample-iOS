// Interactor: Responsible for retrieving data from the model layer, it is independent of the user interface.

import Foundation

final class PhotosInteractor: PhotosInteractorInputProtocol {
    weak var presenter: PhotosInteractorOutputProtocol?
    private let imageLoader: ImageLoader
    private let dataLoader: DataLoader
    private let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .default
        return queue
    }()

    init(dataLoader: DataLoader, imageLoader: ImageLoader) {
        self.dataLoader = dataLoader
        self.imageLoader = imageLoader
    }

    deinit {
        operationQueue.cancelAllOperations()
    }
    
    func loadPhotos() {
        DispatchQueue.global().async { [weak presenter, operationQueue, dataLoader, imageLoader] in
            // Run server locally using `npx http-server`
            let url = URL(string: "http://localhost:8080/photos.json").unsafelyUnwrapped
            guard let photosData = dataLoader.loadData(from: url) else { return }

            let photosEntity: [PhotoEntity]
            do {
                photosEntity = try JSONDecoder().decode([PhotoEntity].self, from: photosData)
            } catch {
                print("Handle error: \(error)")
                return
            }

            let photos = photosEntity.map { Photo(id: $0.id, title: $0.title) }
            presenter?.didFinishLoadingPhotos(photos)

            for (index, photo) in photosEntity.enumerated() {
                operationQueue.addOperation {
                    guard let imageData =  imageLoader.loadImage(from: photo.thumbnailUrl) else { return }
                    presenter?.didLoadThumbnail(photoIndex: index, thumbnail: imageData)
                }
            }

        }
    }
}
