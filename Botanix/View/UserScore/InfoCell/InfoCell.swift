import SwiftUI

struct InfoCell: View {
    let title: String
    let text: String
    
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
                    Text(text)
                        .vText()
                },
                label: {
                    Text("\(title)")
                        .vText(font: .vBodyMediumBold)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
            )
        }
    }
}
