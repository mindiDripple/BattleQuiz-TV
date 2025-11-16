import SwiftUI

struct JoinRoomView: View {
    @EnvironmentObject var app: AppViewModel
    @State private var code: String = ""
    @State private var error: String? = nil

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.indigo.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 28) {
                Text("Enter Room Code")
                    .font(.system(size: 56, weight: .heavy, design: .rounded))
                    .foregroundColor(.cyan)
                    .shadow(color: .cyan.opacity(0.4), radius: 10)

                // Stylized code field
                ZStack {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                        .frame(width: 700, height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .stroke(Color.cyan, lineWidth: 3)
                                .shadow(color: .cyan.opacity(0.5), radius: 10)
                        )

                    HStack(spacing: 40) {
                        ForEach(0..<6, id: \.self) { idx in
                            Text(character(at: idx))
                                .font(.system(size: 52, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
                        }
                    }
                }
                // Hidden text field for input capture (tvOS shows keyboard when focused)
                TextField("", text: $code)
                    .font(.title3)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.numberPad)
                    .frame(width: 0, height: 0)
                    .opacity(0.01)
                    .accessibilityHidden(true)
                    .onChange(of: code) { _, newValue in
                        let digits = newValue.filter { $0.isNumber }
                        code = String(digits.prefix(6))
                    }

                Button(action: joinAction) {
                    Text("Join Game")
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
                .disabled(code.count < 6)

                if let e = error {
                    Text(e).foregroundColor(.red)
                }

                Button("Back") { app.go(.mainMenu) }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .opacity(0.9)
            }
            .padding(60)
        }
    }

    private func character(at index: Int) -> String {
        if index < code.count {
            let i = code.index(code.startIndex, offsetBy: index)
            return String(code[i])
        } else {
            return "_"
        }
    }

    private func joinAction() {
        _ = app.multiplayer.joinRoom(code: code, player: app.currentPlayer).sink { room in
            if let room = room { app.room = room; error = nil; app.go(.lobby) }
            else { error = "Invalid code" }
        }
    }
}
