import SwiftUI

struct EmailUpdateView: View {
    @MainActor @StateObject private var viewModel = EmailUpdateViewModel()
    
    var body: some View {
        generalContetnt()
            .vStandardView()
            .vNavigationBar(navigationTitle: "Email Update", navigationBarBackButtonHidden: false)
            .vStandardAlert($viewModel.alertItem)
            .navigationDestination(isPresented: $viewModel.emailIsUpdated){
                PlantView()
            }
    }
    
    @ViewBuilder
    func generalContetnt() -> some View {
        VStack{
            Spacer()
            vTextField(title: "New Email*", tip: "email@example.com", text: $viewModel.newEmail)
            Spacer().frame(height: 100)
            vButton(action: viewModel.updateEmail, buttonText: "Update Email")
            Spacer()
        }
    }
}
