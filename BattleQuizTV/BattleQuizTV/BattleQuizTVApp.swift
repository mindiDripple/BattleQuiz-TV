//
//  BattleQuizTVApp.swift
//  BattleQuizTV
//
//  Created by STUDENT on 2025-11-15.
//

import SwiftUI

@main
struct BattleQuizTVApp: App {
    @StateObject private var app = AppViewModel()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(app)
        }
    }
}
