import Foundation

class PlantCareAdvisor {
    struct PlantCareTip: Identifiable {
        let id = UUID()
        let category: TipCategory
        let advice: String
        
        enum TipCategory: String {
            case watering
            case light
            case humidity
            case ph
            case nutrients
            case salinity
            case temperature
            case texture
            case soilHumidity
        }
    }
    
    private let plant: PlantDetailsEntity
    
    init(plant: PlantDetailsEntity) {
        self.plant = plant
    }
    
    func careTips() -> [PlantCareTip] {
        var tips: [PlantCareTip] = []
        
        if let tip = wateringAdvice(){
            tips.append(.init(category: .watering, advice: tip))
        }
        if let tip = lightAdvice() {
            tips.append(.init(category: .light, advice: tip))
        }
//        if let tip = humidityAdvice() {
//            tips.append(.init(category: .humidity, advice: tip))
//        }
        if let tip = phAdvice() {
            tips.append(.init(category: .ph, advice: tip))
        }
        if let tip = soilNutrimentsAdvice() {
            tips.append(.init(category: .nutrients, advice: tip))
        }
        if let tip = soilSalinityAdvice() {
            tips.append(.init(category: .salinity, advice: tip))
        }
        if let tip = temperatureAdvice() {
            tips.append(.init(category: .temperature, advice: tip))
        }
        
        return tips
    }
    
    private func wateringAdvice() -> String? {
        guard let min = plant.wateringMin,
              let max = plant.wateringMax else {
            return "Water this plant when the topsoil feels dry to the touch, but avoid overwatering."
        }
        
        func frequencyDescription(for level: Int) -> String {
            switch level {
            case 1:
                return "once every 1–2 weeks"
            case 2:
                return "every 3–5 days"
            case 3:
                return "daily or every other day"
            default:
                return "with unknown frequency"
            }
        }
        
        if min == max {
            let frequency = frequencyDescription(for: min)
            return "Water this plant \(frequency)."
        } else {
            let minFrequency = frequencyDescription(for: min)
            let maxFrequency = frequencyDescription(for: max)
            return "Water this plant from \(minFrequency) to \(maxFrequency), depending on the environment."
        }
    }
    
    private func lightAdvice() -> String? {
        guard let light = plant.light else { return nil }
        switch light {
        case 0...3:
            return "This plant prefers low light. Avoid direct sunlight and place it in a shaded area."
        case 4...6:
            return "This plant prefers moderate light. Place it in a bright spot, but avoid intense midday sun."
        case 7...10:
            return "This plant loves a lot of light. Place it near a sunny window or in direct sunlight."
        default:
            return nil
        }
    }
    
//    private func humidityAdvice() -> String? {
//        guard let humidity = plant.atmosphericHumidity else { return nil }
//        switch humidity {
//        case 0...3:
//            return "The plant tolerates dry air. No extra humidity is needed."
//        case 4...7:
//            return "The plant prefers moderate humidity. Occasional misting is helpful."
//        case 8...10:
//            return "The plant requires high humidity. Use a humidifier or place it near other plants."
//        default:
//            return nil
//        }
//    }
    
    private func phAdvice() -> String? {
        guard let min = plant.phMin, let max = plant.phMax else { return nil }
        return "Maintain soil pH between \(min) and \(max) for optimal growth."
    }
    
    private func soilNutrimentsAdvice() -> String? {
        guard let nutrients = plant.soilNutriments else { return nil }
        switch nutrients {
        case 0...3:
            return "The plant grows in poor soil and does not require much fertilization."
        case 4...7:
            return "The plant prefers moderately fertile soil. Fertilize it regularly during the growing season."
        case 8...10:
            return "The plant needs rich, nutrient-dense soil. Use high-quality compost or fertilizers."
        default:
            return nil
        }
    }
    
    private func soilSalinityAdvice() -> String? {
        guard let salinity = plant.soilSalinity else { return nil }
        switch salinity {
        case 0...3:
            return "The plant is sensitive to salty soil. Use fresh water and avoid salty environments."
        case 4...7:
            return "The plant tolerates moderate salinity. Be cautious with mineral build-up."
        case 8...10:
            return "The plant can grow in salty soil. It is well-suited for coastal environments."
        default:
            return nil
        }
    }
    
    private func temperatureAdvice() -> String? {
        guard let minTemp = plant.minimumTemperatureDegC, let maxTemp = plant.maximumTemperatureDegC else { return nil }
        return "Keep the temperature between \(minTemp)°C and \(maxTemp)°C to keep the plant healthy."
    }
}
