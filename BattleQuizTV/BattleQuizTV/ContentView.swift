//
//  ContentView.swift
//  BattleQuizTV
//
//  Created by STUDENT on 2025-11-15.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var app: AppViewModel
    var body: some View {
        RootView()
            .environmentObject(app)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppViewModel())
}
