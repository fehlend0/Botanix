import Foundation
import UIKit

class AlertUtils {
    static func getAlertItemForError(_ error: Error) -> VAlertItem {
        var localizedDescription = error.localizedDescription
        if localizedDescription.contains("NSLocalizedDescription=") {
            let splittedError = localizedDescription.components(separatedBy: "NSLocalizedDescription=")
            localizedDescription = splittedError[1].components(separatedBy: ", NS")[0]
        }
        
        if localizedDescription.isEmpty {
            localizedDescription = "error_unknown".localized
        }
        
        return VAlertItem(title: "error_title".localized,
                            message: localizedDescription)
    }
    
    static func getAlertItemForUnkownError() -> VAlertItem {
        return VAlertItem(title: "error_title".localized,
                           message: "error_unknown".localized)
    }
    
    static func getAlertItemForMessage(_ message: String, _ title: String) -> VAlertItem {
        return VAlertItem(title: title.localized,
                            message: message)
    }
}
