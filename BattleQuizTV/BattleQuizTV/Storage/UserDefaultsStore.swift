import Foundation

final class UserDefaultsStore {
    private let defaults = UserDefaults.standard

    private enum Keys {
        static let displayName = "profile_display_name"
        static let avatar = "profile_avatar"
        static let settings = "app_settings"
    }

    func saveProfile(name: String, avatar: Avatar) {
        defaults.set(name, forKey: Keys.displayName)
        defaults.set(avatar.rawValue, forKey: Keys.avatar)
    }

    func loadProfile() -> (name: String, avatar: Avatar)? {
        guard let name = defaults.string(forKey: Keys.displayName),
              let avatarRaw = defaults.string(forKey: Keys.avatar),
              let avatar = Avatar(rawValue: avatarRaw) else { return nil }
        return (name, avatar)
    }

    func saveSettings(_ settings: GameSettings) {
        if let data = try? JSONEncoder().encode(settings) {
            defaults.set(data, forKey: Keys.settings)
        }
    }

    func loadSettings() -> GameSettings {
        if let data = defaults.data(forKey: Keys.settings),
           let s = try? JSONDecoder().decode(GameSettings.self, from: data) { return s }
        return .default
    }
}
