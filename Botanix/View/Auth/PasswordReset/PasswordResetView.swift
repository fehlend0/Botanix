import SwiftUI

struct PasswordResetView: View {
    @MainActor @StateObject private var viewModel = PasswordResetViewModel()
    
    var body: some View {
        generalContetnt()
            .vStandardView()
            .vNavigationBar(navigationTitle: "Password Reset", navigationBarBackButtonHidden: false)
            .vStandardAlert($viewModel.alertItem)
            .navigationDestination(isPresented: $viewModel.emailIsSent){
                SignInView()
            }
    }
    
    @ViewBuilder
    func generalContetnt() -> some View {
        VStack{
            Spacer()
            vTextField(title: "Email*", tip: "email@example.com", text: $viewModel.email)
            vInlineAlert(error: $viewModel.error)
            Spacer().frame(height: 100)
            vButton(action: viewModel.resetPassword, buttonText: "Reset Password")
            Spacer()
        }
    }
}



