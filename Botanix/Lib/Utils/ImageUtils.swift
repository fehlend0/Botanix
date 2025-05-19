import UIKit

class ImageUtils {
    private static let imageCompressionQuality = CGFloat(0.9)
    private static let saveToCameraRollKey = "VSaveToCameraRoll"
    private static let standardImageChoosingKey = "VStandardImageChoosingKey"
    
    static func save(image: UIImage, name: String) throws {
        let fileURL = getURLForImage(name: name)
        
        if let data = image.jpegData(compressionQuality: imageCompressionQuality) {
            do {
                try data.write(to: fileURL)
            } catch {
                throw error
            }
        }
    }
    
    static func saveToCameraRoll(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    static func readImage(name: String) -> UIImage? {
        let fileURL = getURLForImage(name: name)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        }
        
        return nil
    }
    
    static func deleteImage(name : String) throws {
        let fileURL = getURLForImage(name: name)
        
        try? FileManager.default.removeItem(at: fileURL)
        
    }
    
    static func getURLForImage(name: String) -> URL {
        let documentsDirectory = getDocumentsDirectory()
        return documentsDirectory.appendingPathComponent(name)
    }
    
    static func setSaveToCamerRoll(_ save: Bool) {
        UserDefaults.standard.set(save, forKey: saveToCameraRollKey)
        UserDefaults.standard.synchronize()
    }
    
    static func shouldSaveToCameraRoll() -> Bool {
        guard let shouldSave = UserDefaults.standard.object(forKey: saveToCameraRollKey) as? Bool else {
            return true //Standard is true
        }
        
        return shouldSave
    }
    
    static func setStandardImageChoosing(_ index: Int) {
        UserDefaults.standard.set(index, forKey: standardImageChoosingKey)
        UserDefaults.standard.synchronize()
    }
    
    static func getStandardImageChoosing() -> Int { //0 = no decision, 1 = camera, 2 = gallery
        guard let standardImageChoosing = UserDefaults.standard.object(forKey: standardImageChoosingKey) as? Int else {
            return 0 //Standard is no decision
        }
        
        return standardImageChoosing
    }
    
    //MARK: - Helper
    private static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
