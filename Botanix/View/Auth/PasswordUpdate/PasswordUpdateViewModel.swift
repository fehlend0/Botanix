import Foundation

@MainActor
final class PasswordUpdateViewModel: ObservableObject {
    @Published var newPassword: String = ""
    @Published var confirmNewPassword: String = ""
    @Published var passwordIsUpdated: Bool = false
    @Published var alertItem: VAlertItem? = nil
    
    var error: String = ""
    
    func updatePassword() async {
        guard isValidPassword() else {
            alertItem = AlertUtils.getAlertItemForMessage(error, "Not allowed to update password")
            return
        }
        
        do {
            try await AuthService.shared.updatePassword(password: newPassword)
            alertItem = AlertUtils.getAlertItemForMessage("Your password was updated successfully.", "Success")
            passwordIsUpdated = true
        } catch {
            alertItem = AlertUtils.getAlertItemForMessage(error.localizedDescription, "Error updating password")
        }
    }
    
    private func isValidPassword() -> Bool {
        let result = PasswordValidator.validate(password: newPassword, confirmation: confirmNewPassword)
        error = result.error ?? ""
        return result.isValid
    }
}
