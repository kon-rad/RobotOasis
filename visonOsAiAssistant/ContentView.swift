//
//  ContentView.swift
//  visonOsAiAssistant
//
//  Created by Konrad Gnat on 2/9/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {

        GeometryReader { geometry in // Use GeometryReader to determine the available height
            VStack {
                // Image view to display a static image named "exampleImage"
                Image("robotics-club-sm")
                    .resizable() // Makes the image resizable
                    .cornerRadius(20)
                    .scaledToFit() // Scales the image to fit its container while maintaining its aspect ratio
                    .frame(width: 100, height: 100) // Optionally, you can specify the frame size
                    .padding(.bottom, 20) // Adds some padding around the image

                Text("Welcome to the Robot Oasis").font(.largeTitle)
                Link("Sign Up Here", destination: URL(string: "https://dashboard.mailerlite.com/forms/727497/112847705875678366/share")!)
                    .font(.title)
                    .padding()

                Toggle("Create a New Event", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
                    .padding(.top, 50)
                Text("Current Events").padding(.top, 20)
                
                // Specify a frame for the ScrollView
                ScrollView {
                    EventsListView()
                        .frame(minHeight: 1000, maxHeight: .infinity) // Adjust the minHeight as needed
                }
                .frame(height: geometry.size.height / 2) // Dynamically set the height based on the available space
            }
            .padding()
            .onChange(of: showImmersiveSpace) { _, newValue in
                Task {
                    if newValue {
                        switch await openImmersiveSpace(id: "ImmersiveSpace") {
                        case .opened:
                            immersiveSpaceIsShown = true
                        case .error, .userCancelled:
                            fallthrough
                        @unknown default:
                            immersiveSpaceIsShown = false
                            showImmersiveSpace = false
                        }
                    } else if immersiveSpaceIsShown {
                        await dismissImmersiveSpace()
                        immersiveSpaceIsShown = false
                    }
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
