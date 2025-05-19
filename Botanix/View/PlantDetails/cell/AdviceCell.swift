import SwiftUI

struct AdviceCell: View {
    let advice: PlantCareAdvisor.PlantCareTip
    
    @State private var isExpanded = false
    
    var body: some View {
        generalContent()
            .vDisclosureGroup()
    }
    
    @ViewBuilder
    private func generalContent() -> some View {
        VStack(alignment: .center){
            DisclosureGroup(
                isExpanded: $isExpanded,
                content: {
                    vDivider()
                    Text(advice.advice)
                        .vText()
                },
                label: {
                    Text("\(advice.category.rawValue.capitalized)")
                        .vText(font: .vBodyMediumBold)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
            )
        }
    }
}
