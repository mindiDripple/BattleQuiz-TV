import SwiftUI

struct AnswerRevealView: View {
    @EnvironmentObject var app: AppViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Answer Reveal").font(.title)
            Button("Next") { app.go(.leaderboard) }
            Button("Back") { app.go(.mainMenu) }
        }
        .padding(40)
    }
}
