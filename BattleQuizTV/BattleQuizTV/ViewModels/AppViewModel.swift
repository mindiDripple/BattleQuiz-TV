import Foundation
import Combine

final class AppViewModel: ObservableObject {
    enum Route {
        case splash
        case welcome
        case mainMenu
        case profile
        case createRoom
        case joinRoom
        case lobby
        case game
        case reveal
        case leaderboard
        case settings
        case quickPlay
    }

    @Published var route: Route = .splash

    @Published var currentPlayer: Player
    @Published var settings: GameSettings
    @Published var room: Room?

    let store = UserDefaultsStore()
    let multiplayer: MultiplayerService

    private var cancellables = Set<AnyCancellable>()

    init(multiplayer: MultiplayerService = MockMultiplayerService()) {
        if let profile = store.loadProfile() {
            currentPlayer = Player(displayName: profile.name, avatar: profile.avatar)
        } else {
            currentPlayer = Player(displayName: "Player", avatar: .robot)
        }
        settings = store.loadSettings()
        self.multiplayer = multiplayer

        multiplayer.roomPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$room)
    }

    func go(_ r: Route) { route = r }
}
