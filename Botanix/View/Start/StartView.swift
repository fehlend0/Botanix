import SwiftUI

struct StartView: View {
    @Binding var showStartView: Bool
    
    var body: some View {
        VStack{
            generalContent()
        }
        .vNavigationBar(navigationTitle: "", navigationBarBackButtonHidden: true)
        .vStandardView()
    }
    
    @ViewBuilder
    func generalContent() -> some View {
        Spacer()
        vDivider()
        Text("Botanix").vText(font: .vHeadlineLarge)
        vDivider()
        Spacer()
        Text("Get personalized care advice for your plants.").vText()
        vImage(imageName: "start", width: 300, height: 400)
        // Spacer()
        vDestinationButton(destination: SignInView(), buttonText: "Get Started")
        Spacer()
    }
}
