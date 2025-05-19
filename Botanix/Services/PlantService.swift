import SwiftUI

final class PlantService {
    static let shared = PlantService()
    
    private var apiManager = ApiManager.shared
    private let apiKeyName: String = "PLANT_API_KEY"
    
    private var plantDetailsCache: PlantDetailsEntity? = nil
    
    private var plantDetailsService = PlantDetailsService.shared
    
    lazy var apiKey: String = {
        guard let apiKey = ProcessInfo.processInfo.environment[apiKeyName] else {
            fatalError("Environment variable \(apiKeyName) not set")
        }
        return apiKey
    }()
    
    private init() {
        apiManager.configure(baseURL: "https://plant.id/api/v3/", headers: ["Api-Key" : apiKey])
    }
    
    public func identifyPlant(image: UIImage) async throws -> PlantEntity?{
        guard let imageData = image.jpegData(compressionQuality: 0.8)?.base64EncodedString() else {
            return nil
        }
        
        let requestBody = PlantIdentificationRequest(
            images: [imageData],
            latitude: 49.207,
            longitude: 16.608,
            similar_images: true
        )
        
        do {
            let response: PlantIdResponse = try await apiManager.request(
                endpoint: "identification",
                method: .POST,
                body: requestBody
            )
            
            guard let classification = response.result?.classification,
                  let firstSuggestion = classification.suggestions.first else {
                return nil
            }
            
            
            // Save the scientific name of the identified plant
            let plantDto = PlantDto(scientificName: firstSuggestion.name)
            
            // Use the scientific name to get the id of the plant to use it for Trefle API, reconfigure the APIManager
            apiManager.configure(baseURL: "https://trefle.io/api/v1/")
            let plantTrefleDto = try await plantDetailsService.getPlantId(scientificName: plantDto.scientificName)
            
            if let id = plantTrefleDto?.id {
                
                // Use the is to get care information
                let plantCareInfo = try await plantDetailsService.getPlantDetails(id: String(id))
                
                let plantDetailsEntity = PlantDetailsEntity(uid: UUID(), wateringMin: firstSuggestion.watering?.min, wateringMax: firstSuggestion.watering?.max, light: plantCareInfo?.light, atmosphericHumidity: plantCareInfo?.atmosphericHumidity, phMax: plantCareInfo?.phMax, phMin: plantCareInfo?.phMin, soilNutriments: plantCareInfo?.soilNutriments, soilSalinity: plantCareInfo?.soilSalinity, soilTexture: plantCareInfo?.soilTexture, soilHumidity: plantCareInfo?.soilHumidity, minimumTemperatureDegC: plantCareInfo?.minimumTemperatureDegC?.deg_c, maximumTemperatureDegC: plantCareInfo?.maximumTemperatureDegC?.deg_c)
                
                plantDetailsCache = plantDetailsEntity
                
                // Create a plant entity with a reference to plant details, which contain care information
                return PlantEntity(uid: UUID(), name: plantTrefleDto!.common_name ?? plantDto.scientificName, belongsTo: AuthService.shared.getUsersUid(), plantDetails: plantDetailsEntity.uid, image: image)
            } else {
                print("The plant's id is nil")
            }
            return nil
            
        } catch {
            print("Request failed: \(error)")
            return nil
        }
    }
    
    func getPlantDetails() async throws -> PlantDetailsEntity? {
        return plantDetailsCache
    }
}
