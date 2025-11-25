# BattleQuizTV 📺🎯

A multiplayer quiz battle game designed specifically for Apple TV (tvOS). Challenge your friends and family in exciting quiz battles from the comfort of your living room!

## 🎮 Features

### Core Gameplay
- **Multiplayer Quiz Battles**: Create or join rooms to compete with friends
- **Real-time Competition**: Live multiplayer gameplay with instant scoring
- **Multiple Difficulty Levels**: Choose from different difficulty settings
- **Quick Play Mode**: Jump into a game instantly
- **Custom Room Creation**: Host your own quiz rooms with personalized settings

### User Experience
- **Player Profiles**: Create and customize your player profile with avatars
- **Leaderboards**: Track your performance and compete for the top spot
- **Room Codes**: Easy room joining system with shareable codes
- **Lobby System**: Wait for players and manage game settings before starting
- **Answer Reveal**: Dramatic answer reveals with scoring feedback

### tvOS Optimized
- **Apple TV Remote Support**: Fully optimized for Siri Remote navigation
- **Living Room UI**: Large, clear interface designed for TV viewing
- **Focus-based Navigation**: Intuitive tvOS focus engine integration

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0 or later
- Apple TV (4th generation or later) or Apple TV Simulator
- iOS/tvOS development environment
- Apple Developer Account (for device testing)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd BattleQuizTV
   ```

2. **Open in Xcode**
   ```bash
   open BattleQuizTV.xcodeproj
   ```

3. **Select Target**
   - Choose "BattleQuizTV" scheme
   - Select Apple TV simulator or connected Apple TV device

4. **Build and Run**
   - Press `Cmd + R` or click the Run button
   - The app will launch on your selected target

### First Launch
1. Create your player profile on the welcome screen
2. Choose an avatar and enter your name
3. Select "Create Room" to host a game or "Join Room" to join an existing game
4. Enjoy the quiz battle!

## 🎯 How to Play

### Creating a Room
1. From the main menu, select "Create Room"
2. Configure game settings (difficulty, number of questions, etc.)
3. Share the generated room code with other players
4. Wait in the lobby for players to join
5. Start the game when ready

### Joining a Room
1. Select "Join Room" from the main menu
2. Enter the room code provided by the host
3. Wait in the lobby for the game to start
4. Get ready to battle!

### During the Game
1. Read each question carefully
2. Select your answer using the Apple TV remote
3. Watch the dramatic answer reveal
4. See your score update in real-time
5. Compete for the top spot on the leaderboard

## 🏗️ Project Structure

```
BattleQuizTV/
├── BattleQuizTV/
│   ├── Models/           # Data models (Question, Player, Room, etc.)
│   ├── Views/            # SwiftUI views for all screens
│   ├── ViewModels/       # App state management
│   ├── Services/         # Multiplayer and question services
│   ├── Storage/          # Data persistence
│   └── Assets.xcassets/  # Images, icons, and colors
├── BattleQuizTVTests/    # Unit tests
└── BattleQuizTVUITests/  # UI tests
```

## 🛠️ Technical Details

- **Framework**: SwiftUI + Combine
- **Platform**: tvOS 17.0+
- **Architecture**: MVVM pattern
- **Multiplayer**: Protocol-based service architecture
- **State Management**: ObservableObject and EnvironmentObject
- **Navigation**: Route-based navigation system

## 🎨 Customization

### Adding Questions
Questions are managed through the `QuestionProvider` service. You can:
- Add new question categories
- Modify difficulty levels
- Import questions from external sources

### Theming
The app uses a consistent design system with:
- Custom colors defined in Assets.xcassets
- Reusable UI components
- tvOS-specific styling and animations

## 🧪 Testing

### Running Tests
```bash
# Unit Tests
Cmd + U

# UI Tests
Select BattleQuizTVUITests scheme and run
```

### Test Coverage
- Model validation and business logic
- View model state management
- UI flow testing
- Multiplayer service mocking

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Built with SwiftUI and the power of tvOS
- Designed for the ultimate living room gaming experience
- Created with ❤️ for quiz enthusiasts everywhere

---

**Ready to battle?** Fire up your Apple TV and let the quiz wars begin! 🏆
