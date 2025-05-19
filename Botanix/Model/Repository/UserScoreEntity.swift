import Foundation
import SwiftData

@Model
class UserScoreEntity {
    @Attribute(.unique) var uid: UUID
    var belongsTo: String
    var score: Int
    var level: Int
    
    
    
    init(uid: UUID, belongsTo: String, score: Int, level: Int) {
        self.uid = uid;
        self.belongsTo = belongsTo;
        self.score = score;
        self.level = level
    }
}
