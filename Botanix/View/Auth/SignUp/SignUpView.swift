import SwiftUI

struct SignUpView: View {
    @MainActor @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        generalContent()
            .vStandardView()
            .vNavigationBar(navigationTitle: "", navigationBarBackButtonHidden: true)
            .navigationDestination(isPresented: $viewModel.signedUp){
                PlantView()
            }
    }
    
    @ViewBuilder
    func generalContent() -> some View {
        VStack{
            Spacer()
            // vTextField(title: "Username*", tip: "username", text: $viewModel.userName)
            vTextField(title: "Email*", tip: "email@example.com", text: $viewModel.email)
            vSecureTextField(title: "Password*", tip: "******************", text: $viewModel.password)
            vSecureTextField(title: "Confirm Password*", tip: "******************", text: $viewModel.passwordConfirmation)
            vInlineAlert(error: $viewModel.error)
            Spacer().frame(height: 100)
            vButton(action: viewModel.signUp, buttonText: "Sign Up")
            vInlineDestinationButton(preText: "Already have an account? ", text: "Sign in", destination: SignInView())
            Spacer()
        }
    }
}

