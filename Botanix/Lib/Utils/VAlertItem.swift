import Foundation
import SwiftUI

public struct VAlertItem: Identifiable {
    public let id = UUID()
    public var title: String
    public var message: String?
    public var dismissButton: Alert.Button
    public var secondaryButton: Alert.Button?
    
    public init(title: String, message: String = "",dismissButton: Alert.Button = .cancel(Text( "Ok".localized) ), secondaryButton: Alert.Button? = nil ) {
        self.title = title
        self.message = message
        self.dismissButton = dismissButton
        self.secondaryButton = secondaryButton
    }
}
