
import Foundation
class DashboardViewModel {
    //MARK: - Variable Declaration
    
    private let networkService: NetworkingService
    private var currentQuery = ""
    var currentPage: Int = 1
    var totalHits: Int = 0
    var searchResults: Observable<[Item]> = Observable([])
    
    //MARK: - Initialization
    
    init(networkService: NetworkingService) {
        self.networkService = networkService
    }
    
    func searchImages(withQuery query: String) {
        // Reset the values for a new search query
        currentQuery = query
        loadNextPage()
    }
    func loadNextPage() {
        networkService.searchNASAImages(withQuery: currentQuery, page: "\(currentPage)") { [weak self] result in
            switch result {
            case .success(let images):
                self?.totalHits = images.metadata?.totalHits ?? 0
                self?.searchResults.value.append(contentsOf: images.items ?? [Item]())
                print("Count : \(self?.searchResults.value.count ?? 0)")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    
}
