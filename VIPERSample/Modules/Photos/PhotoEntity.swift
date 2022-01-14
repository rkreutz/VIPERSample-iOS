import Foundation

// An API/Storage representation of a Photo
struct PhotoEntity: Decodable {
    var id: Int
    var title: String
    var thumbnailUrl: URL
}
