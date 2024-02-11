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
        VStack {
//            Model3D(named: "Scene", bundle: realityKitContentBundle)
//                .padding(.bottom, 50)
            
            // Image view to display a static image named "exampleImage"
            Image("examplimages/eImage")
                .resizable() // Makes the image resizable
                .scaledToFit() // Scales the image to fit its container while maintaining its aspect ratio
                .frame(width: 200, height: 200) // Optionally, you can specify the frame size
                .padding() // Adds some padding around the image

            Text("Welcome to the Robot Oasis")

            Toggle("Create a New Event", isOn: $showImmersiveSpace)
                .toggleStyle(.button)
                .padding(.top, 50)
            Text("Current Events").padding(.top, 20)
            
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

#Preview(windowStyle: .automatic) {
    ContentView()
}
