//
//  BirdChatApp.swift
//  BirdChat
//
//  Created by Yakov Manshin on 10/22/23.
//

import SwiftUI

@main
struct BirdChatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(currentUser: .sampleBird1, otherUser: .sampleBird2)
        }
    }
}
