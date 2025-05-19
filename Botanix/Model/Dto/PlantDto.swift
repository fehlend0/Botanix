import Foundation

struct PlantDto: Codable {
    var scientificName: String
}

struct PlantIdResponse: Decodable {
    let result: ClassificationResult?
}

struct ClassificationResult: Decodable {
    let classification: Classification?
}

struct Classification: Decodable {
    let suggestions: [PlantSuggestion]
}

struct PlantSuggestion: Decodable {
    let name: String
    let watering: Watering?
}

struct PlantIdentificationRequest: Encodable {
    let images: [String]
    let latitude: Double
    let longitude: Double
    let similar_images: Bool
}

struct Watering: Decodable{
    let max: Int
    let min: Int
}


