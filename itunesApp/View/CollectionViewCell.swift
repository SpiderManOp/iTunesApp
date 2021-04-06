import UIKit
class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
   // @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumArtistNameLabel: UILabel!
    
    
    func updateCell(album: AlbumModel) {
       // albumNameLabel.text = album.collectionName
        albumArtistNameLabel.text=album.artistName
        guard let imageUrl = URL(string: album.artworkUrl100) else { return }
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    self.albumImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
}
