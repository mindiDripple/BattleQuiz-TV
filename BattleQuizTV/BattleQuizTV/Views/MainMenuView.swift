import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var app: AppViewModel

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.indigo.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                // Top bar with profile badge
                HStack {
                    Spacer()
                    Button(action: { app.go(.profile) }) {
                        HStack(spacing: 10) {
                            ZStack {
                                Circle().fill(Color.white.opacity(0.08))
                                    .frame(width: 56, height: 56)
                                Text(app.currentPlayer.avatar.rawValue.capitalized.prefix(1))
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .overlay(
                                Circle().stroke(Color.cyan, lineWidth: 3)
                                    .shadow(color: .cyan.opacity(0.6), radius: 6)
                            )
                            Text(app.currentPlayer.displayName)
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 60)
                .padding(.top, 30)

                Spacer()

                // Title
                Text("Main Menu")
                    .font(.system(size: 64, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.bottom, 24)

                // Buttons Stack
                VStack(spacing: 20) {
                    NeonButton(title: "Create Room") { app.go(.createRoom) }
                    NeonButton(title: "Join Room") { app.go(.joinRoom) }
                    NeonButton(title: "Quick Play") { app.go(.quickPlay) }
                    NeonButton(title: "Leaderboard") { app.go(.leaderboard) }
                    NeonButton(title: "Settings") { app.go(.settings) }
                }

                Spacer()
            }
        }
    }
}

private struct NeonButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2.bold())
                .frame(width: 520, height: 70)
        }
        .buttonStyle(.borderedProminent)
        .tint(.purple)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.cyan, lineWidth: 2)
                .shadow(color: .cyan.opacity(0.5), radius: 10)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
