import Foundation

struct Player: Identifiable, Codable, Hashable {
    let id: UUID
    var displayName: String
    var avatar: Avatar
    var isReady: Bool
    var score: Int

    init(id: UUID = UUID(), displayName: String, avatar: Avatar, isReady: Bool = false, score: Int = 0) {
        self.id = id
        self.displayName = displayName
        self.avatar = avatar
        self.isReady = isReady
        self.score = score
    }
}
