//
//  TeslaAppApp.swift
//  TeslaApp
//
//  Created by Vakil on 13.05.2024.
//

import SwiftUI

@main
struct TeslaApp: App {
    var body: some Scene {
        WindowGroup {
            StartView()
                .environment(\.colorScheme, .dark)
        }
    }
}

