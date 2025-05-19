import Foundation

@MainActor
final class SignUpViewModel: ObservableObject {
    //@Published var userName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var error: String = ""
    @Published var signedUp: Bool = false
    
    func signUp() async {
        guard !email.isEmpty, !password.isEmpty, !passwordConfirmation.isEmpty else {
            error  = "Please fill all fields."
            return
        }
        guard isValidPassword() else {
            return }
        do {
            try await AuthService.shared.createUser(email: email, password: password)
            signedUp = true
        } catch {
            self.error  = "Sign-up failed. Try again."
        }
    }
    
    private func isValidPassword() -> Bool {
        let result = PasswordValidator.validate(password: password, confirmation: passwordConfirmation)
        error = result.error ?? ""
        return result.isValid
    }
}
