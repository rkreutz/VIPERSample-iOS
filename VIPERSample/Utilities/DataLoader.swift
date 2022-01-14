import Foundation

protocol DataLoader {

    @discardableResult
    func loadData(from url: URL) -> Data?
}
