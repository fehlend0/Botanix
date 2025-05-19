import Foundation
import SwiftUI
import SwiftData
import Combine

@MainActor
class PlantViewModel: ObservableObject {
    @Published var plants = [PlantEntity]()
    @Published var imageForRequest: String?
    @Published var showSelectImageSourceTypeSheet = false
    @Published var showSelectImagePicker = false
    @Published var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var selectedChildImage: UIImage?
    @Published var showPlantDetails = false
    @Published var alertItem: VAlertItem? = nil
    @Published var showSpinner : Bool = false
    
    var selectedPlant: PlantEntity?
    
    private var modelContext: ModelContext!
    private var plantService = PlantService.shared
    
    func initialize(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData(uid: AuthService.shared.getUsersUid())
    }
    
    func fetchData(uid: String){
        do {
            let descriptor = FetchDescriptor<PlantEntity>(predicate: #Predicate {$0.belongsTo == uid}, sortBy: [SortDescriptor(\.name)])
            plants = try modelContext.fetch(descriptor)
        } catch {
            alertItem = AlertUtils.getAlertItemForError(error)
        }
    }
    
    func onSelectChildImage(image: UIImage) async {
        showSpinner = true
        do {
            let plant: PlantEntity? = try await plantService.identifyPlant(image: image)
            modelContext.insert(plant!)
            
            let plantDetails: PlantDetailsEntity? = try await plantService.getPlantDetails()
            modelContext.insert(plantDetails!)
            
            withAnimation {
                fetchData(uid: AuthService.shared.getUsersUid())
            }
            
            try modelContext.save()
            
        } catch {
            showSpinner = false
            alertItem = AlertUtils.getAlertItemForError(error)
        }
        showSpinner = false
    }
    
    func deletePlant(_ indexSet: IndexSet) {
        for index in indexSet {
            let plant = plants[index]
            modelContext.delete(plant)
            plants.remove(at: index)
            // TODO: delete plant details
        }
        
        try? modelContext.save()
    }
    
    func selectPlant(_ plant: PlantEntity){
        selectedPlant = plant
        showPlantDetails = true
    }
}
