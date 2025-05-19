import SwiftUI

final class PlantDetailsService {
    static let shared = PlantDetailsService()
    
    private let apiManager = ApiManager.shared
    private let apiKeyName = "PLANT_DETAILS_API_KEY"
    
    private lazy var apiKey: String = {
        guard let key = ProcessInfo.processInfo.environment[apiKeyName] else {
            fatalError("Environment variable \(apiKeyName) not set.")
        }
        return key
    }()
    
    private init() {}
    
    func getPlantId(scientificName: String) async throws -> PlantTrefleDto? {
        var components = URLComponents(string: "plants")!
        components.queryItems = [
            URLQueryItem(name: "token", value: apiKey),
            URLQueryItem(name: "filter[scientific_name]", value: scientificName)
        ]
        
        guard let endpoint = components.string else {
            throw RestError.invalidURL
        }
        
        do {
            let response: PlantTrefleResponse = try await apiManager.request(
                endpoint: endpoint,
                method: .GET
            )
            return PlantTrefleDto(id: response.data.first?.id, common_name: response.data.first?.common_name)
            
        } catch {
            print("Error fetching plant ID: \(error)")
            return nil
        }
    }
    
    func getPlantDetails(id: String) async throws -> GrowthDto? {
        var components = URLComponents(string: "species/\(id)")!
        components.queryItems = [
            URLQueryItem(name: "token", value: apiKey)
        ]
        
        guard let endpoint = components.string else {
            throw RestError.invalidURL
        }
        
        do {
            let response: PlantDetailsResponse = try await apiManager.request(
                endpoint: endpoint,
                method: .GET
            )
            
            let data = response.data
            
            guard let growth = data.growth else {
                print("No growth data available")
                return nil
            }
            
            return GrowthDto(
                light: growth.light,
                atmosphericHumidity: growth.atmosphericHumidity,
                phMax: growth.phMax,
                phMin: growth.phMin,
                soilNutriments: growth.soilNutriments,
                soilSalinity: growth.soilSalinity,
                soilTexture: growth.soilTexture,
                soilHumidity: growth.soilHumidity,
                minimumTemperatureDegC: growth.minimumTemperatureDegC,
                maximumTemperatureDegC: growth.maximumTemperatureDegC
            )
        } catch {
            print("Error fetching plant details: \(error)")
            return nil
        }
    }
}
