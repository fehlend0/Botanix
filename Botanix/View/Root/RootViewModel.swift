import SwiftUI

@MainActor
class RootViewModel: ObservableObject {
    @Published var showStartView = false
    
    func checkIfUserAuthenticated() {
        let authUser = try? AuthService.shared.getAuthenticatedUser()
        showStartView = authUser == nil
    }
}
