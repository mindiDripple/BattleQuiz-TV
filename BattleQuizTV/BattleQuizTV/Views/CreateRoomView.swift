import SwiftUI

struct CreateRoomView: View {
    @EnvironmentObject var app: AppViewModel
    @State private var rounds: Int = 5
    @State private var timer: Int = 10
    @State private var difficulty: Difficulty = .medium
    @State private var roomCode: String? = nil

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.indigo.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 32) {
                Text("Configure Game Room")
                    .font(.system(size: 56, weight: .heavy, design: .rounded))
                    .foregroundColor(.cyan)
                    .shadow(color: .cyan.opacity(0.4), radius: 10)

                HStack(alignment: .top, spacing: 40) {
                    // Left: settings with chips
                    VStack(alignment: .leading, spacing: 28) {
                        // Rounds
                        VStack(alignment: .leading, spacing: 10) {
                            Text("ROUNDS").font(.caption).foregroundColor(.white.opacity(0.7))
                            HStack(spacing: 16) {
                                ForEach([5,10,15], id: \.self) { v in
                                    ChipButton(title: "\(v)", isSelected: rounds == v) { rounds = v }
                                }
                            }
                        }

                        // Timer
                        VStack(alignment: .leading, spacing: 10) {
                            Text("TIMER").font(.caption).foregroundColor(.white.opacity(0.7))
                            HStack(spacing: 16) {
                                ForEach([10,15,20], id: \.self) { v in
                                    ChipButton(title: "\(v)s", isSelected: timer == v) { timer = v }
                                }
                            }
                        }

                        // Difficulty
                        VStack(alignment: .leading, spacing: 10) {
                            Text("DIFFICULTY").font(.caption).foregroundColor(.white.opacity(0.7))
                            HStack(spacing: 16) {
                                ForEach(Difficulty.allCases, id: \.self) { d in
                                    ChipButton(title: d.rawValue.capitalized, isSelected: difficulty == d) { difficulty = d }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: 700, alignment: .leading)

                    // Divider
                    Rectangle().fill(Color.white.opacity(0.08)).frame(width: 2).cornerRadius(1)

                    // Right: Big code
                    VStack(spacing: 16) {
                        Text(roomCode ?? "——— ———")
                            .font(.system(size: 96, weight: .heavy, design: .rounded))
                            .foregroundColor(.cyan)
                            .shadow(color: .cyan.opacity(0.5), radius: 12)
                            .monospaced()
                        Text("Share this code with your friends!")
                            .foregroundColor(.white.opacity(0.9))
                            .font(.title3)
                    }
                    .frame(maxWidth: .infinity)
                }

                // CTA
                Button(action: {
                    // Ensure room is created
                    app.settings = GameSettings(rounds: rounds, timerSeconds: timer, difficulty: difficulty)
                    if app.room == nil || app.room?.code != roomCode {
                        _ = app.multiplayer.createRoom(settings: app.settings, host: app.currentPlayer).sink { room in
                            roomCode = room.code
                            app.room = room
                            app.go(.lobby)
                        }
                    } else {
                        app.go(.lobby)
                    }
                }) {
                    Text("Go to Lobby")
                        .font(.title2.bold())
                        .padding(.horizontal, 36)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.cyan, lineWidth: 2)
                        .shadow(color: .cyan.opacity(0.5), radius: 10)
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Button("Back") { app.go(.mainMenu) }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .opacity(0.9)
            }
            .padding(60)
        }
    }
}

private struct ChipButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
        }
        .buttonStyle(.borderedProminent)
        .tint(isSelected ? .cyan : .purple)
        .opacity(isSelected ? 1.0 : 0.85)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
