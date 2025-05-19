import Foundation

@MainActor
final class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    @Published var isSignedIn: Bool = false
    
    func signUp() async throws {
    }
    
    func signIn() async {
        guard !email.isEmpty, !password.isEmpty else {
            self.error = "Please enter your email and password."
            return
        }
        do {
            try await AuthService.shared.signIn(email: email, password: password)
            isSignedIn = true
        } catch {
            self.error = "Wrong password or email."
        }
    }
}
