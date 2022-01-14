import Foundation

final class URLSessionDataLoader: DataLoader {

    static let shared = URLSessionDataLoader()

    private init() {}

    func loadData(from url: URL) -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        var loadedData: Data?
        URLSession.shared.dataTask(
            with: url,
            completionHandler: { data, _, error in
                defer { semaphore.signal() }
                guard
                    error == nil,
                    let data = data
                else { return }

                loadedData = data
            }
        ).resume()

        semaphore.wait()
        return loadedData
    }
}
