
import UIKit
class DetailVC: UIViewController {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    var networkManager = APImanager()
    var album: AlbumModel!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInfo()
    }
    func updateInfo() {
        albumImageView.image = image
        artistLabel.text = album.artistName
        albumLabel.text = album.collectionName
        releaseDateLabel.text = String(album.releaseDate.prefix(10))
    }
}
 
