import Foundation
import SwiftData

@MainActor
final class UserScoreViewModel: ObservableObject {
    @Published var score: Int = 0
    @Published var title: String = ""
    
    private var modelContext: ModelContext!
    private var userScore: UserScoreEntity!
    
    func initialize(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        userScore = fetchOrCreateUserScore()
        updateLevelAndPoints()
    }
    
    private func fetchOrCreateUserScore() -> UserScoreEntity? {
        let userUid = AuthService.shared.getUsersUid()
        
        do {
            let descriptor = FetchDescriptor<UserScoreEntity>(
                predicate: #Predicate { $0.belongsTo == userUid }
            )
            
            if let existingScore = try modelContext.fetch(descriptor).first {
                return existingScore
            }
            
            let newScore = UserScoreEntity(uid: UUID(), belongsTo: userUid, score: 0, level: 0)
            modelContext.insert(newScore)
            return newScore
            
        } catch {
            print("Failed to fetch or create user score: \(error)")
            return nil
        }
    }
    
    public func claimPoints() {
        userScore.score += 5
        userScore.level += 5
        try? modelContext.save()
        
        updateLevelAndPoints()
    }
    
    private func updateLevelAndPoints() {
        score = userScore.score
        title = figureOutTitle()
    }
    
    private func figureOutTitle() -> String {
        switch userScore.level {
        case 0..<20:
            return "🌱 Sprouting Seed"
        case 20..<40:
            return "🪴 Potting Beginner"
        case 40..<60:
            return "🍃 Hopeful Leaf"
        case 60..<80:
            return "🌿 Green Companion"
        case 80..<100:
            return "🌻 Casual Gardener"
        case 100..<120:
            return "🌴 Jungle Tamer"
        case 120..<140:
            return "🌸 Blooming Wizard"
        case 140..<160:
            return "🌾 Agro Dreamer"
        case 160..<180:
            return "🌺 Plant Care Pro"
        default:
            return "🌳 Supreme Botanist"
        }
    }
}
