import SwiftUI

struct QuickPlayView: View {
    @EnvironmentObject var app: AppViewModel
    @State private var cpuCount: Int = 2
    @State private var difficulty: Difficulty = .medium

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.indigo.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 28) {
                Text("Quick Play")
                    .font(.system(size: 56, weight: .heavy, design: .rounded))
                    .foregroundColor(.cyan)

                VStack(alignment: .leading, spacing: 18) {
                    Text("CPU Opponents").font(.headline).foregroundColor(.white.opacity(0.9))
                    HStack(spacing: 16) {
                        ForEach([0,1,2,3], id: \.self) { n in
                            Button(action: { cpuCount = n }) {
                                Text("\(n)")
                                    .font(.headline)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(cpuCount == n ? .cyan : .purple)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                    }

                    Text("Difficulty").font(.headline).foregroundColor(.white.opacity(0.9))
                    HStack(spacing: 16) {
                        ForEach(Difficulty.allCases, id: \.self) { d in
                            Button(action: { difficulty = d }) {
                                Text(d.rawValue.capitalized)
                                    .font(.headline)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(difficulty == d ? .cyan : .purple)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                    }
                }

                Button(action: startSolo) {
                    Text("Start Solo Game")
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

    private func startSolo() {
        // Configure settings from current app settings but override difficulty
        let settings = GameSettings(rounds: app.settings.rounds, timerSeconds: app.settings.timerSeconds, difficulty: difficulty)
        app.settings = settings

        var players: [Player] = [app.currentPlayer]
        let cpuNames = ["QuizBot","PixelCPU","TriviaAI","DataDroid","LogicLlama","AnswerAnt"]
        let avatars = Avatar.allCases
        for i in 0..<cpuCount {
            let name = cpuNames[i % cpuNames.count]
            let avatar = avatars[(i + 1) % avatars.count]
            players.append(Player(displayName: name, avatar: avatar, isReady: true))
        }

        let localRoom = Room(code: "LOCAL", hostId: app.currentPlayer.id, settings: settings, players: players)
        app.room = localRoom
        app.go(.game)
    }
}
