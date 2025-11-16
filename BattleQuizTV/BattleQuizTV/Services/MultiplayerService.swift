import Foundation
import Combine

protocol MultiplayerService {
    var playersPublisher: AnyPublisher<[Player], Never> { get }
    var roomPublisher: AnyPublisher<Room?, Never> { get }

    func createRoom(settings: GameSettings, host: Player) -> AnyPublisher<Room, Never>
    func joinRoom(code: String, player: Player) -> AnyPublisher<Room?, Never>
    func setReady(playerId: UUID, ready: Bool)
    func startGame()
}
