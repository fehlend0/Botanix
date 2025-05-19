import Foundation

public struct VSettingsButton: Identifiable {
    public let id: UUID = UUID()
    public let buttonText: String
    public let action: @MainActor () async -> Void
}
