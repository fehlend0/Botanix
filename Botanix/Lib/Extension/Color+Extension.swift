import Foundation
import SwiftUI

public extension Color {
    static let ui = Color.UI()
    
    struct UI {
        public let accent = Color("AccentAppColor")
        public let background = Color("BackgroundAppColor")
        public let cellBackground = Color("CellBackgroundAppColor")
        public let text = Color("TextAppColor")
        public let danger = Color("DangerAppColor")
    }
    
    func uiColor() -> UIColor {
        return UIColor(self)
    }
}
