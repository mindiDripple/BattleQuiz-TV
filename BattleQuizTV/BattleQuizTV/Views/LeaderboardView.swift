import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var app: AppViewModel
    @State private var tab: Tab = .global

    enum Tab: String, CaseIterable { case global = "Global", weekly = "Weekly", friends = "Friends" }

    struct Entry: Identifiable {
        let id = UUID()
        let name: String
        let score: Int
        let avatarInitial: String
    }

    private var data: [Entry] {
        // Placeholder mock data. Later can load from persistence or service.
        switch tab {
        case .global:
            return [
                Entry(name: "QuizMaster", score: 12450, avatarInitial: "Q"),
                Entry(name: "PixelPatrol", score: 10980, avatarInitial: "P"),
                Entry(name: "TriviaTitan", score: 9120, avatarInitial: "T")
            ]
        case .weekly:
            return [
                Entry(name: "WeeklyWarrior", score: 8450, avatarInitial: "W"),
                Entry(name: "SwiftSage", score: 7990, avatarInitial: "S"),
                Entry(name: "LogicLion", score: 7320, avatarInitial: "L")
            ]
        case .friends:
            return [
                Entry(name: app.currentPlayer.displayName, score: 6500, avatarInitial: String(app.currentPlayer.displayName.prefix(1))),
                Entry(name: "BuddyOne", score: 5200, avatarInitial: "B"),
                Entry(name: "BuddyTwo", score: 4800, avatarInitial: "B")
            ]
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.indigo.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                // Tabs
                HStack(spacing: 16) {
                    ForEach(Tab.allCases, id: \.self) { t in
                        SegChip(title: t.rawValue, selected: tab == t) { tab = t }
                    }
                }

                Text("Leaderboard")
                    .font(.system(size: 56, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)

                HStack(alignment: .top, spacing: 28) {
                    // Ranks 1-3 column
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Rank").font(.headline).foregroundColor(.white.opacity(0.9))
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(1...3, id: \.self) { r in
                                HStack(spacing: 10) {
                                    if r == 1 { Text("🥇").font(.title2) }
                                    else if r == 2 { Text("2") }
                                    else { Text("3") }
                                }
                                .frame(height: 48)
                            }
                        }
                    }
                    .frame(width: 120)

                    // Table content
                    VStack(spacing: 12) {
                        // Header row
                        HStack {
                            Text("Avatar").frame(width: 160, alignment: .leading)
                            Text("Player").frame(maxWidth: .infinity, alignment: .leading)
                            Text("Score").frame(width: 180, alignment: .trailing)
                        }
                        .foregroundColor(.white.opacity(0.8))

                        VStack(spacing: 14) {
                            ForEach(Array(data.enumerated()), id: \.offset) { idx, e in
                                LBRow(entry: e)
                            }
                        }
                    }
                }

                Button("Back") { app.go(.mainMenu) }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .opacity(0.9)
            }
            .padding(60)
        }
    }
}

private struct SegChip: View {
    var title: String
    var selected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
        }
        .buttonStyle(.borderedProminent)
        .tint(selected ? .cyan : .purple)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .opacity(selected ? 1.0 : 0.85)
    }
}

private struct LBRow: View {
    var entry: LeaderboardView.Entry

    var body: some View {
        HStack(spacing: 12) {
            // Avatar placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white.opacity(0.08))
                    .frame(width: 140, height: 56)
                Text(entry.avatarInitial)
                    .font(.title3)
                    .foregroundColor(.white)
            }

            Text(entry.name)
                .foregroundColor(.white)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("\(entry.score, format: .number)")
                .foregroundColor(.pink)
                .font(.title3)
                .frame(width: 180, alignment: .trailing)
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
