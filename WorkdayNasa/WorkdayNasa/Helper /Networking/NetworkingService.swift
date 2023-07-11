
import Foundation

class NetworkingService {
    
    //MAKR: - Instance Properties
    internal let baseURL = URL(string: WebServiceURLs.mainURL)!
    func searchNASAImages(withQuery query: String, page: String, completion: @escaping (Result<Collection, Error>) -> Void) {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(WebServiceParameter.paramSearch), resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: WebServiceParameter.paramPage, value: page)
        ]
        
        guard let url = urlComponents?.url else {
            completion(.failure(NetworkError.notAuthenticated))
            return
        }
        
        // Create the request
        let request = URLRequest(url: url)
        
        // Make the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchData = try decoder.decode(NasaCollectionModel.self, from: data)
                    completion(.success(searchData.collection!))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
}
