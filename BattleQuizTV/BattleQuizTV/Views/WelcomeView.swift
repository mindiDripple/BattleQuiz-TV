import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var app: AppViewModel

    var body: some View {
        ZStack {
            // Background gradient similar to the mock
            LinearGradient(colors: [Color.black, Color.indigo.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                // App Logo image
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 700)
                    .shadow(color: Color.cyan.opacity(0.4), radius: 14)

                // Subtitle
                Text("Challenge your friends to the ultimate trivia showdown!")
                    .font(.title2)
                    .foregroundColor(Color.white.opacity(0.9))
                    .multilineTextAlignment(.center)

                // Primary CTA Button
                Button(action: { app.go(.mainMenu) }) {
                    Text("Start Quizzing")
                        .font(.title2).bold()
                        .padding(.horizontal, 32)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.cyan)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color.cyan.opacity(0.5), radius: 12, x: 0, y: 6)
                .padding(.top, 8)

                Spacer()
            }
            .padding(60)
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AppViewModel())
}
