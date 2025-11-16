import Foundation

struct Question: Identifiable, Codable, Equatable {
    let id: UUID
    let prompt: String
    let options: [String] // exactly 4
    let correctIndex: Int

    init(id: UUID = UUID(), prompt: String, options: [String], correctIndex: Int) {
        self.id = id
        self.prompt = prompt
        self.options = options
        self.correctIndex = correctIndex
    }
}
