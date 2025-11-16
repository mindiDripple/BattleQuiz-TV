import Foundation

struct GameSettings: Codable, Equatable {
    var rounds: Int
    var timerSeconds: Int
    var difficulty: Difficulty

    static let `default` = GameSettings(rounds: 5, timerSeconds: 15, difficulty: .medium)
}
