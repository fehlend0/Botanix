import Foundation
import SwiftData

@Model
class PlantDetailsEntity {
    @Attribute(.unique) var uid: UUID
    var wateringMin: Int?
    var wateringMax: Int?
    var light: Int?
    var atmosphericHumidity: Int?
    var phMax: Double?
    var phMin: Double?
    var soilNutriments: Int?
    var soilSalinity: Int?
    var soilTexture: String?
    var soilHumidity: Int?
    var minimumTemperatureDegC: Double?
    var maximumTemperatureDegC: Double?
    
    
    init(uid: UUID, wateringMin: Int?, wateringMax: Int?, light: Int?, atmosphericHumidity: Int?, phMax: Double?, phMin: Double?, soilNutriments: Int?, soilSalinity: Int?, soilTexture: String?, soilHumidity: Int?, minimumTemperatureDegC: Double?, maximumTemperatureDegC: Double?) {
        self.uid = uid;
        self.wateringMin = wateringMin;
        self.wateringMax = wateringMax;
        self.light = light;
        self.atmosphericHumidity = atmosphericHumidity;
        self.phMax = phMax;
        self.phMin = phMin;
        self.soilNutriments = soilNutriments;
        self.soilSalinity = soilSalinity;
        self.soilTexture = soilTexture;
        self.soilHumidity = soilHumidity;
        self.minimumTemperatureDegC = minimumTemperatureDegC;
        self.maximumTemperatureDegC = maximumTemperatureDegC
    }
}


