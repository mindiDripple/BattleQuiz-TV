import Foundation

struct RoundResult: Identifiable, Codable, Equatable {
    let id: UUID
    let questionId: UUID
    let playerId: UUID
    let selectedIndex: Int?
    let isCorrect: Bool
    let pointsEarned: Int

    init(id: UUID = UUID(), questionId: UUID, playerId: UUID, selectedIndex: Int?, isCorrect: Bool, pointsEarned: Int) {
        self.id = id
        self.questionId = questionId
        self.playerId = playerId
        self.selectedIndex = selectedIndex
        self.isCorrect = isCorrect
        self.pointsEarned = pointsEarned
    }
}
