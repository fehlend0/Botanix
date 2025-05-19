import Foundation
import SwiftUI

struct RootView: View {
    @MainActor @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                generalContent()
            }.task{
                viewModel.checkIfUserAuthenticated()
            }
            .navigationDestination(isPresented: $viewModel.showStartView){
                StartView(showStartView: $viewModel.showStartView)
            }
        }.tint(Color.ui.text)
    }
    
    @ViewBuilder
    private func generalContent() -> some View {
        PlantView()
    }
}
