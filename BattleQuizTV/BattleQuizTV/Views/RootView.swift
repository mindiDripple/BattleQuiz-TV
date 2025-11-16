import SwiftUI

struct RootView: View {
    @EnvironmentObject var app: AppViewModel

    var body: some View {
        Group {
            switch app.route {
            case .splash: SplashView()
            case .welcome: WelcomeView()
            case .mainMenu: MainMenuView()
            case .profile: ProfileView()
            case .createRoom: CreateRoomView()
            case .joinRoom: JoinRoomView()
            case .lobby: LobbyView()
            case .game: GameView()
            case .reveal: AnswerRevealView()
            case .leaderboard: LeaderboardView()
            case .settings: SettingsView()
            case .quickPlay: QuickPlayView()
            }
        }
        .environmentObject(app)
    }
}
