import UIKit
class HomeVC: UIViewController {
    @IBOutlet weak var searcher: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var networkManager = APImanager()
    var albumsArray = [AlbumModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searcher.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueForPassData" {
            if let destinationVC = segue.destination as? DetailVC {
                if let album = sender as? AlbumModel {
                    destinationVC.album = album
                    let index = albumsArray.firstIndex(where: {$0 === album})
                    let indexPath = IndexPath(row: index!, section: 0)
                    if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                        destinationVC.image = cell.albumImageView.image
                    }
                }
            }
        }
    }
}
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as? CollectionViewCell {
            cell.updateCell(album: albumsArray[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueForPassData", sender: albumsArray[indexPath.row])
        searcher.resignFirstResponder()
    }
}
extension HomeVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        networkManager.getAlbumData(searchRequest: searchBarText) { (albumSearchResult) in
            self.albumsArray = albumSearchResult.sorted(by: {$0.collectionName < $1.collectionName})
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
}
