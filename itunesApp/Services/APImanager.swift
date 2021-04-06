import Foundation
class APImanager {
    func getAlbumData(searchRequest: String, completion: @escaping ([AlbumModel])->()) {
        var albums = [AlbumModel]()
        let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://itunes.apple.com/search?term=\(searchString)")
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let albumsResults = json["results"] as? NSArray {
                        for album in albumsResults {
                            if let albumInfo = album as? [String: AnyObject] {
                                guard let artistName = albumInfo["artistName"] as? String else { return }
                                guard let artworkUrl100 = albumInfo["artworkUrl100"] as? String else { return }
                                guard let collectionName = albumInfo["collectionName"] as? String else { return }
                                guard let releaseDate = albumInfo["releaseDate"] as? String else { return }
                                let albumInstance = AlbumModel(artistName: artistName, artworkUrl100: artworkUrl100, collectionName: collectionName, releaseDate: releaseDate)
                                albums.append(albumInstance)
                            }
                        }
                        completion(albums)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error!.localizedDescription)
            }
        }.resume()
    }
}

