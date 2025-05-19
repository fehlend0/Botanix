import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var loggedOut : Bool = false
    @Published var alertItem: VAlertItem? = nil
    
    func signOut() {
        do {
            try AuthService.shared.signOut()
            loggedOut = true
        } catch {
            // TODO: add error handling
        }
    }
    
    func resetPassword() async {
        do {
            let authUser = try AuthService.shared.getAuthenticatedUser()
            guard let email = authUser.email else {
                alertItem = AlertUtils.getAlertItemForMessage("Couldn't get email.", "Error")
                return
            }
            try await AuthService.shared.resetPassword(email: email)
            alertItem = AlertUtils.getAlertItemForMessage("Password reset email was sent.", "Check your inbox")
        } catch {
            // TODO: add error handling
        }
    }
    
    func updateEmail() async {
        // TODO: get user's input
        
        do {
            try await AuthService.shared.updateEmail(email: "fakeemail@mail.ru")
        } catch {
            // TODO: add error handling
        }
    }
}
