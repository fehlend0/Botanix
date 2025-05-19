import Foundation
import SwiftData

@MainActor
class PlantDetailsViewModel: ObservableObject {
    @Published var showSpinner : Bool = false
    @Published var alertItem: VAlertItem? = nil
    @Published var plantDetails: PlantDetailsEntity!
    @Published var careTips = [PlantCareAdvisor.PlantCareTip]()
    
    private var modelContext: ModelContext!
    
    func initialize(_ modelContext: ModelContext, plantDetailsUid: UUID) {
        self.modelContext = modelContext
        fetchData(uid: plantDetailsUid)
    }
    
    func fetchData(uid: UUID) {
        do {
            let descriptor = FetchDescriptor<PlantDetailsEntity>(
                predicate: #Predicate { $0.uid == uid }
            )
            
            plantDetails = try modelContext.fetch(descriptor).first
            
            let advisor = PlantCareAdvisor(plant: plantDetails)
            careTips =  advisor.careTips()
            
        } catch {
            alertItem = AlertUtils.getAlertItemForError(error)
        }
    }
}
