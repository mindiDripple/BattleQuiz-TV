import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var app: AppViewModel
    @State private var soundOn: Bool = true
    @State private var parental: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Settings").font(.title)
            Toggle("Sound", isOn: $soundOn)
            Toggle("Parental Controls", isOn: $parental)
            Button("Save") { app.store.saveSettings(app.settings); app.go(.mainMenu) }
            Button("Back") { app.go(.mainMenu) }
        }
        .padding(40)
    }
}
