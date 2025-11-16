import SwiftUI

struct SplashView: View {
    @EnvironmentObject var app: AppViewModel
    @State private var scale: CGFloat = 0.8
    @State private var glow: Double = 0.4

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.indigo.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                ZStack {
                    Circle()
                        .fill(Color.cyan.opacity(0.15))
                        .frame(width: 300, height: 300)
                        .shadow(color: Color.cyan.opacity(glow), radius: 30)
                    Image(systemName: "lightbulb.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .foregroundColor(.yellow)
                }
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                        scale = 1.0
                        glow = 0.8
                    }
                }

                Text("BattleQuizTV")
                    .font(.system(size: 72, weight: .heavy, design: .rounded))
                    .foregroundColor(.cyan)
                    .shadow(color: .cyan.opacity(0.6), radius: 16)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                app.go(.welcome)
            }
        }
    }
}

#Preview {
    SplashView().environmentObject(AppViewModel())
}
