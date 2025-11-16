import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var app: AppViewModel
    @State private var name: String = ""
    @State private var selected: Avatar = .robot

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.indigo.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            HStack(alignment: .center, spacing: 40) {
                // Left column: Title, Name field, Save button, Selected avatar preview
                VStack(alignment: .leading, spacing: 24) {
                    Text("Set Up Your Profile")
                        .font(.system(size: 64, weight: .heavy, design: .rounded))
                        .foregroundColor(.cyan)
                        .shadow(color: .cyan.opacity(0.4), radius: 12)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Display Name")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.9))
                        HStack(spacing: 16) {
                            TextField("Display Name", text: $name)
                                .font(.title3)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .frame(width: 520)
                                .background(
                                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .fill(Color.white.opacity(0.08))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )

                            // Selected avatar preview circle with glow
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.08))
                                    .frame(width: 90, height: 90)
                                Text(selected.rawValue.capitalized.prefix(1))
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .overlay(
                                Circle()
                                    .stroke(Color.cyan, lineWidth: 4)
                                    .shadow(color: .cyan.opacity(0.6), radius: 10)
                            )
                        }
                    }

                    Button(action: {
                        app.store.saveProfile(name: name.isEmpty ? app.currentPlayer.displayName : name, avatar: selected)
                        app.currentPlayer.displayName = name.isEmpty ? app.currentPlayer.displayName : name
                        app.currentPlayer.avatar = selected
                        app.go(.mainMenu)
                    }) {
                        Text("Save Profile")
                            .font(.title2).bold()
                            .padding(.horizontal, 28)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.cyan)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(color: .cyan.opacity(0.5), radius: 12, x: 0, y: 6)

                    Button("Back") { app.go(.mainMenu) }
                        .buttonStyle(.bordered)
                        .tint(.white)
                        .opacity(0.9)

                    Spacer()
                }
                .frame(maxWidth: 700, alignment: .leading)

                // Separator
                Rectangle()
                    .fill(Color.white.opacity(0.08))
                    .frame(width: 2)
                    .cornerRadius(1)

                // Right column: Avatar grid
                VStack(alignment: .center, spacing: 24) {
                    let cols: [GridItem] = Array(repeating: GridItem(.fixed(140), spacing: 28), count: 4)
                    LazyVGrid(columns: cols, spacing: 28) {
                        ForEach(Avatar.allCases, id: \.self) { a in
                            Button(action: { selected = a }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.white.opacity(0.08))
                                        .frame(width: 120, height: 120)
                                    Text(a.rawValue.capitalized.prefix(1))
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                                .overlay(
                                    Circle()
                                        .stroke(selected == a ? Color.cyan : Color.white.opacity(0.2), lineWidth: selected == a ? 4 : 1)
                                        .shadow(color: selected == a ? Color.cyan.opacity(0.6) : .clear, radius: 10)
                                )
                            }
                            .buttonStyle(.plain) // tvOS focus visuals will still highlight
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding(60)
        }
        .onAppear {
            name = app.currentPlayer.displayName
            selected = app.currentPlayer.avatar
        }
    }
}
