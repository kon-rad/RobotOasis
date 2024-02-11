//
//  GroupWatchView.swift
//  visonOsAiAssistant
//
//  Created by lily liao on 2/10/24.
//

import SwiftUI

struct GroupWatchView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    GroupWatchView()
}

import SwiftUI
import Combine

struct GroupWatchView: View {
    @StateObject private var coordinationManager = CoordinationManager.shared
    @State private var isShareSheetPresented = false
    @State private var isSharePlayPresented = false

    let playerView: MoviePlayerView
    var listView: MovieListView?
    var infoView: MovieInfoView?

    var body: some View {
        VStack(spacing: 20) {
            playerView
                .aspectRatio(16/9, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: traitCollection.userInterfaceIdiom == .pad ? 4 : 0))
                // Present the "What Happened?" button if enabled.
                .overlay(whatHappenedButton, alignment: .bottom)

            // Dynamically show the list or info view based on what's available.
            if let listView = listView {
                listView
            } else if let infoView = infoView {
                infoView
            }
        }
        .navigationBarItems(trailing: HStack {
            Button(action: { isShareSheetPresented = true }) {
                Image(systemName: "square.and.arrow.up")
            }
            .disabled(!coordinationManager.hasMovie)

            Button(action: { isSharePlayPresented = true }) {
                Image(systemName: "shareplay")
            }
            .disabled(!(coordinationManager.hasMovie && !coordinationManager.hasActivity))
        })
        .sheet(isPresented: $isShareSheetPresented) {
            // Present share sheet. This is a placeholder for actual implementation.
        }
        // Additional logic for presenting SharePlay or handling other actions
    }

    @ViewBuilder
    private var whatHappenedButton: some View {
        if coordinationManager.player.isWhatHappenedEnabled {
            Button("What Happened") {
                coordinationManager.player.performWhatHappened()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

struct MovieListView: View {
    var body: some View {
        // Custom list UI
        Text("List View")
    }
}

struct MovieInfoView: View {
    var body: some View {
        // Custom info UI
        Text("Info View")
    }
}

// Assuming CoordinationManager is your custom class managing the state
class CoordinationManager: ObservableObject {
    static let shared = CoordinationManager()
    @Published var hasMovie = false
    @Published var hasActivity = false

    // Placeholder properties and methods
    var player = MoviePlayer() // Assuming this is a custom struct or class

    private init() {}
}

// Placeholder for the movie player functionality
class MoviePlayer {
    var isWhatHappenedEnabled = false

    func performWhatHappened() {
        // Implementation here
    }
}

// Required to access `traitCollection` within SwiftUI
extension View {
    var traitCollection: UITraitCollection {
        return UITraitCollection.current
    }
}
