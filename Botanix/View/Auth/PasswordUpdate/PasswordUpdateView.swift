import SwiftUI

struct PasswordUpdateView: View {
    @MainActor @StateObject private var viewModel = PasswordUpdateViewModel()
    
    var body: some View {
        generalContetnt()
            .vStandardView()
            .vNavigationBar(navigationTitle: "Password Update", navigationBarBackButtonHidden: false)
            .vStandardAlert($viewModel.alertItem)
            .navigationDestination(isPresented: $viewModel.passwordIsUpdated){
                PlantView()
            }
    }
    
    @ViewBuilder
    func generalContetnt() -> some View {
        VStack{
            Spacer()
            vSecureTextField(title: "New password*", tip: "******************", text: $viewModel.newPassword)
            vSecureTextField(title: "Confirm password*", tip: "******************", text: $viewModel.confirmNewPassword)
            Spacer().frame(height: 100)
            vButton(action: viewModel.updatePassword, buttonText: "Update Password")
            Spacer()
        }
    }
}
