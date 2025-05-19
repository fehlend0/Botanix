import Foundation
import SwiftUI

public struct VDestinationSettingsButton: Identifiable {
    public let id: UUID = UUID()
    public let buttonText: String
    public let destination: () -> AnyView
    
    public init<V: View>(buttonText: String, destination: @escaping () -> V) {
        self.buttonText = buttonText
        self.destination = { AnyView(destination()) }
    }
}
