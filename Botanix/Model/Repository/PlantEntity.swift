import Foundation
import SwiftData
import SwiftUI

@Model
class PlantEntity {
    @Attribute(.unique) var uid: UUID
    var name: String
    var belongsTo: String // uid of the signed in user, as String because it comes from Firebase
    var plantDetails: UUID
    var imageData: Data
    
    init(uid: UUID, name: String, belongsTo: String, plantDetails: UUID, image: UIImage) {
        self.uid = uid
        self.name = name
        self.belongsTo = belongsTo
        self.plantDetails = plantDetails
        let resizedImage = image.convert(toWidth: 200)
        self.imageData = resizedImage.jpegData(compressionQuality: 0.8) ?? Data()
    }
    
    var image: UIImage? {
        UIImage(data: imageData)
    }
}


