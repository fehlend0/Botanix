import SwiftUI

struct PlantView: View {
    @MainActor @StateObject private var viewModel = PlantViewModel()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ZStack{
            if viewModel.showSpinner {
                ProgressView()
                    .vStandardView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else {
                generalContent()
            }
        }.task{
            viewModel.initialize(modelContext)
        }
        .navigationDestination(isPresented: $viewModel.showPlantDetails){
            if let plant = viewModel.selectedPlant {
                PlantDetailsView(plant: plant)
            }
        }
        .vNavigationBar(navigationTitle: "My Plants", navigationBarBackButtonHidden: true, withSettingsButton: true)
        .vStandardView()
        .vStandardAlert($viewModel.alertItem)
        .actionSheet(isPresented: $viewModel.showSelectImageSourceTypeSheet) {
            ActionSheet(title: Text("Select Image Source"), buttons: [
                .default(Text("Take a Picture")) {
                    viewModel.imagePickerSourceType = .camera
                    viewModel.showSelectImagePicker = true
                },
                .default(Text("Choose from Gallery")) {
                    viewModel.imagePickerSourceType = .photoLibrary
                    viewModel.showSelectImagePicker = true
                },
                .cancel()
            ])
        }
        .sheet(isPresented: $viewModel.showSelectImagePicker) {
            VImagePicker(image: $viewModel.selectedChildImage, sourceType: viewModel.imagePickerSourceType)
        }
        .onChange(of: viewModel.selectedChildImage) { newValue in
            guard let image = newValue else {
                return
            }
            Task {
                await viewModel.onSelectChildImage(image: image)
            }
        }
    }
    
    @ViewBuilder
    private func generalContent() -> some View{
        VStack {
            if viewModel.plants.isEmpty {
                Spacer()
                Text("🪴 You haven't added any plants yet.")
                    .vText()
                    .padding(.bottom, 50)
            } else {
                List{
                    ForEach(viewModel.plants) { plant in
                        PlantCell(plant: plant)
                            .onTapGesture {
                                viewModel.selectPlant(plant)
                            }
                    }.onDelete(perform: viewModel.deletePlant)
                }.vListStyle()
            }
            
            vButton(action: {
                viewModel.showSelectImageSourceTypeSheet = true
            }, buttonText: "Add a Plant")
            
            if viewModel.plants.isEmpty {
                Spacer()
            }
        }.frame(maxWidth: .infinity)
    }
}
