
import UIKit

class DashboardVC: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgNASAlogo: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cvSearchList: UICollectionView!
    
    //MARK: - Variable Declaration
    
    private var objDetailVC: DetailVC?
    private var viewModel: DashboardViewModel!
    
    //MARK: - Default Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialization()
    }
    
    //MARK: - Initialization
    func initialization(){
        imgNASAlogo.image = UIImage.gifImageWithName("nasaGif")
        imgBackground.image = UIImage.gifImageWithName("Background")
        viewModel = DashboardViewModel(networkService: NetworkingService())
        
        // Bind the collection view to the search results
        viewModel.searchResults.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.cvSearchList.reloadData()
            }
        }
        
        self.cvSearchList?.register(UINib(nibName: "SearchCVCell", bundle: nil), forCellWithReuseIdentifier: "SearchCVCell")
    }
    //MARK: - Load more data methods
    
    func loadMoreData() {
        if viewModel.currentPage < viewModel.totalHits {
            viewModel.currentPage += 1
            viewModel.searchImages(withQuery: searchBar.text ?? "")
            
        }
    }
}

// MARK: - UISearchBarDelegate
extension DashboardVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        viewModel.searchImages(withQuery: query)
        searchBar.resignFirstResponder()
    }
}

//MARK: - UICollectionView Delegate & DataSource methods

extension DashboardVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchResults.value.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCVCell", for: indexPath) as? SearchCVCell else {
            return UICollectionViewCell()
        }
        
        let searchResult = viewModel.searchResults.value[indexPath.item]
        cell.lblSearchTitle?.text = searchResult.data?.first?.title
        
        if  let url = URL(string: searchResult.links?.first?.href ?? ""), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            
            DispatchQueue.main.async {
                cell.imgSearchImage.image = image
            }
        }
        if indexPath.item == viewModel.searchResults.value.count - 1 {
            loadMoreData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  5
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        let cell = self.cvSearchList.cellForItem(at: indexPath) as! SearchCVCell
        
        self.objDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC
        self.objDetailVC!.modalPresentationStyle = .popover
        let popover = self.objDetailVC!.popoverPresentationController
        let _ = objDetailVC?.view
        self.objDetailVC?.imgDetail.image = cell.imgSearchImage.image
        self.objDetailVC?.fetchData(detail: viewModel.searchResults.value[indexPath.item])
        popover?.passthroughViews = [self.view]
        popover?.sourceRect = CGRect(x: 250, y: 500, width: 0, height: 0)
        self.objDetailVC!.preferredContentSize = CGSize(width: 250, height: 419)
        popover!.sourceView = self.view
        self.present(self.objDetailVC!, animated: true, completion: nil)
    }
    
}

