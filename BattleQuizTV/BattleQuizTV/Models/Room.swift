import Foundation

struct Room: Identifiable, Codable, Equatable {
    let id: UUID
    var code: String
    var hostId: UUID
    var settings: GameSettings
    var players: [Player]

    init(id: UUID = UUID(), code: String, hostId: UUID, settings: GameSettings, players: [Player]) {
        self.id = id
        self.code = code
        self.hostId = hostId
        self.settings = settings
        self.players = players
    }
}
