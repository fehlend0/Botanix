import Foundation

struct PlantTrefleDto: Codable {
    let id: Int?
    let common_name: String?
}

struct PlantTrefleResponse: Decodable {
    let data: [PlantData]
}

struct PlantData: Decodable {
    let id: Int?
    let common_name: String?
}

