import SwiftUI

struct PlantCell: View {
    let plant: PlantEntity
    
    var body: some View {
        generalContent()
            .vCellView()
    }
    
    @ViewBuilder
    private func generalContent() -> some View {
        HStack{
            Spacer()
            vCellImage(image: plant.image!, width: 105, height: 105, cornerRadius: 10)
            Spacer()
            Text(plant.name).vText(color: Color.ui.text)
            Spacer()
        }
    }
}
