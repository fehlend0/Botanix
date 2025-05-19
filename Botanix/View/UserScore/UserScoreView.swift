import SwiftUI

struct UserScoreView : View {
    let plantName: String
    
    @MainActor @StateObject private var viewModel = UserScoreViewModel()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ZStack{
            generalContent()
                .vStandardView()
                .vNavigationBar(navigationTitle: "Points Overview", navigationBarBackButtonHidden: false)
        }.task{
            viewModel.initialize(modelContext)
        }
    }
    
    @ViewBuilder
    func generalContent() -> some View {
        VStack(spacing: 20){
            Spacer()
            Text("Your Points: \(viewModel.score)").vText(font: .vBodyMediumBold)
            Text("Your Level: \(viewModel.title)").vText(font: .vBodyMediumBold)
            vDivider()
            ScrollView{
                InfoCell(title: "When should I claim points?", text: "On the previous page, you saw a list of care instructions for your plant. \n Claim your points if all conditions are met and you’ve recently or just now taken care of your plant.")
                InfoCell(title: "How can I spend my points?", text: "You can add up to 3 plants for free. \n Want more? Unlock additional plant slots for 20 points each and keep growing your garden!")
                InfoCell(title: "Levels description", text: "In Botanix, you earn points by caring for your plants. The more consistent you are, the higher your level! Levels unlock every 20 points, starting from 🌱 Sprouting Seed all the way to 🌳 Supreme Botanist. \n Can you reach the top? Keep growing — your plants are counting on you!")
            }
            vButton(action: viewModel.claimPoints, buttonText: "Claim Points for \(plantName)")
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
