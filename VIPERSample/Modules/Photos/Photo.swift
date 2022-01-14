import Foundation

// A domain specific representation of a Photo
struct Photo: Identifiable {
    let id: Int
    var title: String
    var thumbnail: Data?
}
