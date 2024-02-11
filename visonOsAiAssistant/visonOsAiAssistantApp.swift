//
//  visonOsAiAssistantApp.swift
//  visonOsAiAssistant
//
//  Created by Konrad Gnat on 2/9/24.
//

import SwiftUI

@main
struct visonOsAiAssistantApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
