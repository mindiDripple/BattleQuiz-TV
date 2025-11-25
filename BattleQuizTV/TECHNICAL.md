# BattleQuizTV - Technical Documentation 🔧

This document provides detailed technical information for developers working on BattleQuizTV.

## 📋 Table of Contents
- [Architecture Overview](#architecture-overview)
- [Data Models](#data-models)
- [Services](#services)
- [View Architecture](#view-architecture)
- [State Management](#state-management)
- [Navigation System](#navigation-system)
- [Development Guidelines](#development-guidelines)

## 🏗️ Architecture Overview

BattleQuizTV follows the **MVVM (Model-View-ViewModel)** architecture pattern with SwiftUI and Combine:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│     Views       │◄──►│   ViewModels    │◄──►│    Services     │
│   (SwiftUI)     │    │  (ObservableObj)│    │   (Protocols)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│     Models      │    │     Storage     │    │   Mock Services │
│   (Structs)     │    │  (Persistence)  │    │   (Testing)     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 📊 Data Models

### Core Models

#### `Question`
```swift
struct Question: Identifiable, Codable, Equatable {
    let id: UUID
    let prompt: String
    let options: [String] // exactly 4 options
    let correctIndex: Int
}
```

#### `Player`
```swift
struct Player: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var avatar: Avatar
    var score: Int
    var isReady: Bool
}
```

#### `Room`
```swift
struct Room: Identifiable, Codable, Equatable {
    let id: UUID
    var code: String
    var hostId: UUID
    var settings: GameSettings
    var players: [Player]
}
```

#### `GameSettings`
```swift
struct GameSettings: Codable, Equatable {
    var difficulty: Difficulty
    var questionCount: Int
    var timePerQuestion: TimeInterval
}
```

### Supporting Models
- **`Avatar`**: Player avatar representation
- **`Difficulty`**: Game difficulty levels
- **`RoundResult`**: Individual round scoring and results

## 🔧 Services

### MultiplayerService Protocol
```swift
protocol MultiplayerService {
    var playersPublisher: AnyPublisher<[Player], Never> { get }
    var roomPublisher: AnyPublisher<Room?, Never> { get }
    
    func createRoom(settings: GameSettings, host: Player) -> AnyPublisher<Room, Never>
    func joinRoom(code: String, player: Player) -> AnyPublisher<Room?, Never>
    func setReady(playerId: UUID, ready: Bool)
    func startGame()
}
```

### Current Implementations
- **`MockMultiplayerService`**: Local testing implementation
- **Future**: Network-based multiplayer service

### QuestionProvider
Manages question data and provides questions based on difficulty and category.

## 🖼️ View Architecture

### Navigation Flow
```
SplashView → WelcomeView → MainMenuView
                              ├── ProfileView
                              ├── CreateRoomView → LobbyView
                              ├── JoinRoomView → LobbyView
                              ├── QuickPlayView
                              └── SettingsView

LobbyView → GameView → AnswerRevealView → LeaderboardView
```

### Key Views

#### `RootView`
Central navigation hub using route-based navigation:
```swift
struct RootView: View {
    @EnvironmentObject var app: AppViewModel
    
    var body: some View {
        Group {
            switch app.route {
            case .splash: SplashView()
            case .welcome: WelcomeView()
            case .mainMenu: MainMenuView()
            // ... other routes
            }
        }
    }
}
```

#### View Responsibilities
- **SplashView**: App initialization and loading
- **WelcomeView**: First-time user onboarding
- **MainMenuView**: Primary navigation hub
- **CreateRoomView**: Room creation and configuration
- **JoinRoomView**: Room joining interface
- **LobbyView**: Pre-game player management
- **GameView**: Active quiz gameplay
- **AnswerRevealView**: Answer feedback and scoring
- **LeaderboardView**: Final results and rankings

## 🔄 State Management

### AppViewModel
Central state manager using `@StateObject` and `@EnvironmentObject`:

```swift
class AppViewModel: ObservableObject {
    @Published var route: AppRoute = .splash
    @Published var currentPlayer: Player?
    @Published var currentRoom: Room?
    
    // Navigation methods
    func navigate(to route: AppRoute)
    func goBack()
}
```

### State Flow
1. **App Launch**: `SplashView` → `WelcomeView` (if first launch)
2. **User Creation**: Player profile setup
3. **Room Management**: Create/join room workflows
4. **Game Flow**: Lobby → Game → Results → Menu

## 🧭 Navigation System

### AppRoute Enum
```swift
enum AppRoute {
    case splash
    case welcome
    case mainMenu
    case profile
    case createRoom
    case joinRoom
    case lobby
    case game
    case reveal
    case leaderboard
    case settings
    case quickPlay
}
```

### Navigation Patterns
- **Centralized Routing**: All navigation through `AppViewModel`
- **Environment Injection**: Views receive app state via `@EnvironmentObject`
- **Declarative Navigation**: SwiftUI's declarative approach with state-driven UI

## 🎯 tvOS Specific Considerations

### Focus Management
- Use `.focusable()` modifier for custom focus behavior
- Implement proper focus guides for complex layouts
- Test navigation with Apple TV remote

### UI Guidelines
- **Minimum Touch Target**: 250x100 points
- **Safe Areas**: Account for TV overscan
- **Typography**: Use large, readable fonts
- **Contrast**: Ensure high contrast for TV viewing

### Remote Control
- **Menu Button**: Navigate back/exit
- **Play/Pause**: Game actions
- **Touch Surface**: Selection and navigation
- **Siri Remote**: Voice commands (future feature)

## 🧪 Development Guidelines

### Code Style
- **SwiftUI**: Prefer declarative syntax
- **Combine**: Use publishers for async operations
- **Protocol-Oriented**: Design with protocols for testability
- **SOLID Principles**: Follow SOLID design principles

### Testing Strategy
- **Unit Tests**: Model validation and business logic
- **Integration Tests**: Service interactions
- **UI Tests**: Critical user flows
- **Mock Services**: Isolate external dependencies

### Performance Considerations
- **Memory Management**: Avoid retain cycles with weak references
- **Image Optimization**: Use appropriate image sizes for TV
- **Animation Performance**: Smooth 60fps animations
- **Network Efficiency**: Minimize data usage for multiplayer

### Future Enhancements
- **Real Network Multiplayer**: Replace mock service
- **Game Center Integration**: Leaderboards and achievements
- **Voice Control**: Siri Remote voice commands
- **Custom Question Import**: User-generated content
- **Spectator Mode**: Watch games in progress
- **Tournament Mode**: Bracket-style competitions

## 🔍 Debugging Tips

### Common Issues
1. **Focus Problems**: Check `.focusable()` modifiers
2. **State Updates**: Ensure `@Published` properties are used
3. **Memory Leaks**: Use Instruments to detect retain cycles
4. **Navigation Issues**: Verify route state management

### Development Tools
- **Xcode Simulator**: Test on various Apple TV models
- **Instruments**: Profile performance and memory usage
- **SwiftUI Inspector**: Debug view hierarchies
- **Console Logging**: Add strategic logging for debugging

---

This technical documentation should be updated as the project evolves. For questions or clarifications, please refer to the main README or create an issue.
