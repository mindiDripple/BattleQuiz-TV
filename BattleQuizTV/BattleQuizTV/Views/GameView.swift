import SwiftUI

struct GameView: View {
    @EnvironmentObject var app: AppViewModel
    @State private var currentIndex: Int = 0
    @State private var selection: Int? = nil
    @State private var questions: [Question] = []

    var body: some View {
        VStack(spacing: 16) {
            Text("Game").font(.title)
            if currentIndex < questions.count {
                let q = questions[currentIndex]
                Text(q.prompt).font(.title2).multilineTextAlignment(.center)
                VStack(spacing: 12) {
                    ForEach(0..<q.options.count, id: \.self) { i in
                        Button(q.options[i]) { selection = i; app.go(.reveal) }
                            .buttonStyle(.bordered)
                    }
                }
            } else {
                Text("No questions")
            }
            Button("Back") { app.go(.mainMenu) }
        }
        .onAppear {
            questions = QuestionProvider.generateLocalQuestions(count: app.settings.rounds, difficulty: app.settings.difficulty)
        }
        .padding(40)
    }
}
