import Foundation
import Combine

final class MockMultiplayerService: MultiplayerService {
    private let playersSubject = CurrentValueSubject<[Player], Never>([])
    private let roomSubject = CurrentValueSubject<Room?, Never>(nil)

    var playersPublisher: AnyPublisher<[Player], Never> { playersSubject.eraseToAnyPublisher() }
    var roomPublisher: AnyPublisher<Room?, Never> { roomSubject.eraseToAnyPublisher() }

    func createRoom(settings: GameSettings, host: Player) -> AnyPublisher<Room, Never> {
        let code = String(Int.random(in: 100000...999999))
        let room = Room(code: code, hostId: host.id, settings: settings, players: [host])
        roomSubject.send(room)
        playersSubject.send([host])
        return Just(room).eraseToAnyPublisher()
    }

    func joinRoom(code: String, player: Player) -> AnyPublisher<Room?, Never> {
        guard var room = roomSubject.value, room.code == code else {
            return Just(nil).eraseToAnyPublisher()
        }
        room.players.append(player)
        roomSubject.send(room)
        playersSubject.send(room.players)
        return Just(room).eraseToAnyPublisher()
    }

    func setReady(playerId: UUID, ready: Bool) {
        guard var room = roomSubject.value else { return }
        room.players = room.players.map { p in
            var copy = p
            if p.id == playerId { copy.isReady = ready }
            return copy
        }
        roomSubject.send(room)
        playersSubject.send(room.players)
    }

    func startGame() {
        // no-op for now
    }
}
