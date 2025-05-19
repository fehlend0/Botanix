import SwiftUI

struct SettingsView : View {
    @MainActor @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        generalContent()
            .vStandardView()
            .vNavigationBar(navigationTitle: "Settings", navigationBarBackButtonHidden: false)
            .vStandardAlert($viewModel.alertItem)
            .navigationDestination(isPresented: $viewModel.loggedOut){
                SignInView()
            }
    }
    
    @ViewBuilder
    func generalContent() -> some View {
        ScrollView{
            VStack(spacing: 15) {
                Spacer()
                
                vSettingsSection(header: "EMAIL", buttons: [], destinationButtons: [VDestinationSettingsButton(buttonText: "Update email", destination: {EmailUpdateView()})])
                
                Spacer()
                
                vSettingsSection(
                    header: "PASSWORD",
                    buttons: [
                        VSettingsButton(buttonText: "Reset password", action: { await viewModel.resetPassword() })
                    ],
                    destinationButtons: [
                        VDestinationSettingsButton(buttonText: "Update password", destination: { PasswordUpdateView()})
                    ]
                )
                
                vSettingsSection(header: "", buttons: [VSettingsButton(buttonText: "Log out", action: viewModel.signOut)], destinationButtons: [])
            }
        }
    }
}

