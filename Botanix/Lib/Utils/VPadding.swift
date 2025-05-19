import SwiftUI

class VPadding {
    private static var basePadding: Float = 16.0

    static var smallPadding: Float {
        basePadding / 2
    }

    static var mediumPadding: Float {
        basePadding
    }

    static var largePadding: Float {
        basePadding * 2
    }

    static func adjustPaddingsToDisplay() {
        let scale = Float(UIScreen.main.scale)

        basePadding = {
            switch scale {
            case ..<1.4:
                return 8.0
            case ..<1.5:
                return 10.0
            case ..<1.6:
                return 12.0
            case ..<1.8:
                return 14.0
            default:
                return 16.0
            }
        }()
    }
}
