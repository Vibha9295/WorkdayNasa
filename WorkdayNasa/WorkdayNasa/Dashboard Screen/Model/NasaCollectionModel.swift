
import Foundation

// MARK: - NasaCollectionModel
struct NasaCollectionModel: Decodable {
    let collection: Collection?
    enum CodingKeys: String, CodingKey {
        
        case collection = "collection"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collection = try values.decodeIfPresent(Collection.self, forKey: .collection)
    }
}

// MARK: - Collection
struct Collection: Decodable {
    let version: String?
    let href: String?
    let items: [Item]?
    let metadata: Metadata?
    let links: [CollectionLink]?
    enum CodingKeys: String, CodingKey {
        
        case version = "version"
        case href = "href"
        case items = "items"
        case metadata = "metadata"
        case links = "links"
    }
}

// MARK: - Item
struct Item: Decodable {
    let href: String?
    let data: [Datum]?
    let links: [ItemLink]?
    enum CodingKeys: String, CodingKey {
        
        case href = "href"
        case data = "data"
        case links = "links"
    }
    
}

// MARK: - Datum
struct Datum: Decodable {
    let description : String?
    let title : String?
    let photographer : String?
    let location : String?
    let nasa_id : String?
    let date_created : String?
    let keywords : [String]?
    let media_type : String?
    let center : String?
    
    enum CodingKeys: String, CodingKey {
        
        case description = "description"
        case title = "title"
        case photographer = "photographer"
        case location = "location"
        case nasa_id = "nasa_id"
        case date_created = "date_created"
        case keywords = "keywords"
        case media_type = "media_type"
        case center = "center"
    }
}

enum MediaType: String, Codable {
    case audio = "audio"
    case image = "image"
    case video = "video"
}

// MARK: - ItemLink
struct ItemLink: Decodable {
    let href: String?
    let rel: Rel?
    let prompt : String?
    let render: MediaType?
}

enum Rel: String, Codable {
    case captions = "captions"
    case preview = "preview"
}

// MARK: - CollectionLink
struct CollectionLink: Codable {
    let rel, prompt: String?
    let href: String?
}

// MARK: - Metadata
struct Metadata: Decodable {
    let totalHits: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}
