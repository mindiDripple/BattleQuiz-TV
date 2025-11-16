import SwiftUI

struct LobbyView: View {
    @EnvironmentObject var app: AppViewModel

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.indigo.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            if let room = app.room {
                VStack(spacing: 28) {
                    // Header with small room code
                    HStack {
                        Text("Room Code: \(room.code)")
                            .font(.title)
                            .foregroundColor(.cyan)
                            .shadow(color: .cyan.opacity(0.4), radius: 8)
                        Spacer()
                    }
                    .padding(.horizontal, 60)

                    HStack(alignment: .top, spacing: 40) {
                        // Left: player list + Ready button
                        VStack(alignment: .leading, spacing: 18) {
                            ForEach(room.players) { p in
                                PlayerRow(name: p.displayName, isReady: p.isReady)
                            }

                            HStack(spacing: 24) {
                                Button("I'm Ready!") {
                                    app.multiplayer.setReady(playerId: app.currentPlayer.id, ready: true)
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.cyan)
                                .frame(width: 260, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                                Button("Back") { app.go(.mainMenu) }
                                    .buttonStyle(.bordered)
                                    .tint(.white)
                                    .opacity(0.9)
                            }
                            .padding(.top, 8)
                        }
                        .frame(maxWidth: 700, alignment: .leading)

                        // Divider
                        Rectangle().fill(Color.white.opacity(0.08)).frame(width: 2).cornerRadius(1)

                        // Right: big code + Start Game
                        VStack(spacing: 18) {
                            Text(room.code)
                                .font(.system(size: 96, weight: .heavy, design: .rounded))
                                .foregroundColor(.cyan)
                                .shadow(color: .cyan.opacity(0.5), radius: 12)
                                .monospaced()
                            Text("Share code with your friends!")
                                .foregroundColor(.white.opacity(0.9))
                                .font(.title3)

                            let isHost = room.hostId == app.currentPlayer.id
                            let allReady = room.players.count >= 2 && room.players.allSatisfy { $0.isReady }
                            Button("Start Game") { app.go(.game) }
                                .buttonStyle(.borderedProminent)
                                .tint(.purple)
                                .background(
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .stroke(Color.cyan, lineWidth: 2)
                                        .shadow(color: .cyan.opacity(0.5), radius: 10)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .disabled(!(isHost && allReady))
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 60)
                }
            } else {
                VStack(spacing: 16) {
                    Text("No room")
                    Button("Back") { app.go(.mainMenu) }
                }
            }
        }
    }
}

private struct PlayerRow: View {
    var name: String
    var isReady: Bool

    var body: some View {
        HStack {
            // Placeholder avatar circle with initial
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.white.opacity(0.08))
                    .frame(width: 64, height: 64)
                Text(String(name.prefix(1)))
                    .foregroundColor(.white)
                    .font(.title3)
            }
            Text(name)
                .foregroundColor(.white)
                .font(.title3)
                .padding(.leading, 10)
            Spacer()
            Image(systemName: isReady ? "checkmark.circle.fill" : "clock.fill")
                .foregroundColor(isReady ? .green : .yellow)
                .font(.title2)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white.opacity(0.06))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        )
    }
}
