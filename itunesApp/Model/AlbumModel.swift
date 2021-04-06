import Foundation
class AlbumModel {
    let artistName: String
    let artworkUrl100: String
    let collectionName: String
    let releaseDate: String
    init(artistName: String, artworkUrl100: String, collectionName: String, releaseDate: String) {
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.collectionName = collectionName
        self.releaseDate = releaseDate
    }
}
