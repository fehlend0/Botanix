import SwiftUI

struct PlantDetailsView: View {
    let plant: PlantEntity
    
    @MainActor @StateObject var viewModel = PlantDetailsViewModel()
    @Environment(\.modelContext) var modelContext
    
    @State private var tips : [PlantCareAdvisor.PlantCareTip]? = nil
    
    var body: some View {
        ZStack{
            if viewModel.showSpinner {
                ProgressView()
                    .vStandardView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                generalContent()
                    .vStandardView()
                    .vNavigationBar(navigationTitle: "Plant Information", navigationBarBackButtonHidden: false, withSettingsButton: true)
            }
        }.task{
            viewModel.initialize(modelContext, plantDetailsUid: plant.plantDetails)
        }
    }
    
    @ViewBuilder
    func generalContent() -> some View {
        VStack(spacing: 20){
            vCellImage(image: plant.image!, width: 150, height: 150, cornerRadius: 100)
            Text(plant.name).vText(font: .vHeadlineSmall)
            
            if !viewModel.careTips.isEmpty {
                List(viewModel.careTips, id: \.id) { careTip in
                    AdviceCell(advice: careTip)
                }
                .vListStyle()
            }
            
            vInlineDestinationButton(preText: "Care done?", text: "Claim Points", destination: UserScoreView(plantName: plant.name), alignment: .center)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
