import FirebaseAuth

final class AuthService{
    static let shared = AuthService()
    private init(){}
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthData {
        let authData = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthData(user: authData.user)
    }
    
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthData {
        let authData = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthData(user: authData.user)
    }
    
    func getAuthenticatedUser() throws -> AuthData {
        guard let user = Auth.auth().currentUser else {
            // TODO: add error handling
            throw URLError(.badServerResponse)
        }
        return AuthData(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func resetPassword(email: String) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws{
        guard let user = Auth.auth().currentUser else {
            // TODO: add error handling
            throw URLError(.badServerResponse)
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws{
        guard let user = Auth.auth().currentUser else {
            // TODO: add error handling
            throw URLError(.badServerResponse)
        }
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
    func getUsersUid() ->  String {
        do {
            let usersUid = try AuthService.shared.getAuthenticatedUser().uid
            return usersUid
        } catch {
            return ""
        }
    }
}
