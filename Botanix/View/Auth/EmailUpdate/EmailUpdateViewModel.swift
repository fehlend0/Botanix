import Foundation

@MainActor
final class EmailUpdateViewModel: ObservableObject {
    @Published var newEmail: String = ""
    @Published var emailIsUpdated: Bool = false
    @Published var alertItem: VAlertItem? = nil
    
    func updateEmail() async {
        guard !newEmail.isEmpty else {
            alertItem = AlertUtils.getAlertItemForMessage("The new email field can't be empty.", "Not allowed to update email")
            return
        }
        
        do {
            try await AuthService.shared.updateEmail(email: newEmail)
            alertItem = AlertUtils.getAlertItemForMessage("Emai verification was sent.", "Check your inbox")
            emailIsUpdated = true
        } catch {
            alertItem = AlertUtils.getAlertItemForMessage(error.localizedDescription, "Error updating email")
        }
    }
}

