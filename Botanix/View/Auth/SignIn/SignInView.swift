import SwiftUI

struct SignInView: View {
    @MainActor @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        generalContent()
            .vStandardView()
            .vNavigationBar(navigationTitle: "", navigationBarBackButtonHidden: true)
            .navigationDestination(isPresented: $viewModel.isSignedIn){
                PlantView()
            }
    }
    
    @ViewBuilder
    func generalContent() -> some View {
        VStack{
            Spacer()
            Text("🌱 Care. Grow. Bloom.").vText(font: .vBodySmall)
            Spacer().frame(height: 100)
            vTextField(title: "Email*", tip: "email@example.com", text: $viewModel.email)
            vSecureTextField(title: "Password*", tip: "******************", text: $viewModel.password)
            vInlineDestinationButton(preText: "Forgot your password?", text: "Reset it", destination: PasswordResetView(), alignment: .leading)
            vInlineAlert(error: $viewModel.error)
            Spacer().frame(height: 100)
            vButton(action: viewModel.signIn, buttonText: "Sign In")
            vInlineDestinationButton(preText: "New to Botanix? ", text: "Sign up", destination: SignUpView())
            Spacer()
        }
    }
}

