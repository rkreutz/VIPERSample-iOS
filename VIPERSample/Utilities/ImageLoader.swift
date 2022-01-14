import Foundation

final class ImageLoader {

    static let shared = ImageLoader(dataLoader: URLSessionDataLoader.shared)

    private let dataLoader: DataLoader
    private let cache = NSCache<NSURL, NSData>()

    init(dataLoader: DataLoader) {
        self.dataLoader = dataLoader
    }

    func loadImage(from url: URL) -> Data? {
        if let data = cache.object(forKey: url as NSURL) {
            return data as Data
        } else {
            guard let data = dataLoader.loadData(from: url) else { return nil }
            cache.setObject(data as NSData, forKey: url as NSURL)
            return data
        }
    }
}
