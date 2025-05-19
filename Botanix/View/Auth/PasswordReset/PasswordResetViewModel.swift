import Foundation

@MainActor
final class PasswordResetViewModel: ObservableObject {
    @Published var alertItem: VAlertItem? = nil
    @Published var email: String = ""
    @Published var error: String = ""
    @Published var emailIsSent: Bool = false
    
    func resetPassword() async {
        guard !email.isEmpty else {
            self.error = "Please enter your email."
            return
        }
        
        do {
            try await AuthService.shared.resetPassword(email: email)
            alertItem = AlertUtils.getAlertItemForMessage("Password reset email was sent.", "Check your inbox")
            emailIsSent = true
        } catch {
            alertItem = AlertUtils.getAlertItemForMessage(error.localizedDescription, "Error reseting password")
        }
    }
}
