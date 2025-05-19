import Foundation

struct PlantDetailsResponse: Codable {
    let data: PlantDetailsDto
}

struct PlantDetailsDto: Codable {
    let growth: GrowthDto?
}

struct GrowthDto: Codable {
    let light: Int?
    let atmosphericHumidity: Int?
    let phMax: Double?
    let phMin: Double?
    let soilNutriments: Int?
    let soilSalinity: Int?
    let soilTexture: String?
    let soilHumidity: Int?
    let minimumTemperatureDegC: Temperature?
    let maximumTemperatureDegC: Temperature?
    
    enum CodingKeys: String, CodingKey {
        case light
        case atmosphericHumidity = "atmospheric_humidity"
        case phMax = "ph_maximum"
        case phMin = "ph_minimum"
        case soilNutriments = "soil_nutriments"
        case soilSalinity = "soil_salinity"
        case soilTexture = "soil_texture"
        case soilHumidity = "soil_humidity"
        case minimumTemperatureDegC = "minimum_temperature"
        case maximumTemperatureDegC = "maximum_temperature"
    }
}

struct Temperature: Codable {
    let deg_c: Double?
}
