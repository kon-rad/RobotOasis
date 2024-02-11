//
//  MoviePlayerView.swift
//  visonOsAiAssistant
//
//  Created by lily liao on 2/10/24.
//
import SwiftUI
import AVKit
import Combine
import GroupActivities

struct Movie {
    let title: String
    let url: URL
}

class MoviePlayerViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var isWhatHappenedEnabled: Bool = true
    
    private var subscriptions = Set<AnyCancellable>()
    private let player = AVPlayer()
    
    init() {
        // The movie subscriber
        CoordinationManager.shared.$enqueuedMovie
            .receive(on: RunLoop.main)
            .sink { [weak self] movie in
                self?.movie = movie
                self?.updateMovie(movie)
            }
            .store(in: &subscriptions)
        
        // The group session subscriber
        CoordinationManager.shared.$groupSession
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                // Handle group session updates
            }
            .store(in: &subscriptions)
        
        // Example of observing player's timeControlStatus to hide/show poster
        // Implement similar logic based on your app's requirements
    }
    
    private func updateMovie(_ movie: Movie?) {
        guard let movie = movie else {
            player.replaceCurrentItem(with: nil)
            return
        }
        
        let playerItem = AVPlayerItem(url: movie.url)
        player.replaceCurrentItem(with: playerItem)
        print("🍿 \(movie.title) enqueued for playback.")
    }
    
    func performWhatHappened() {
        // Example logic for performWhatHappened
    }
}

struct MoviePlayerView: View {
    @StateObject private var viewModel = MoviePlayerViewModel()
    
    var body: some View {
        VStack {
            // Replace with your SwiftUI video player view
            VideoPlayer(player: viewModel.player)
                .onAppear {
                    viewModel.player.play()
                }
            // Add other UI components based on your requirements
        }
        .navigationBarItems(trailing: Button("What Happened", action: viewModel.performWhatHappened)
            .disabled(!viewModel.isWhatHappenedEnabled))
    }
}

// Example of a SwiftUI video player that wraps AVPlayer
struct SwiftUIVideoPlayer: View {
    let player: AVPlayer
    
    var body: some View {
        VideoPlayer(player: player)
            .aspectRatio(contentMode: .fit)
    }
}

// Assuming CoordinationManager is your custom class for managing app state
class CoordinationManager: ObservableObject {
    static let shared = CoordinationManager()
    @Published var enqueuedMovie: Movie?
    @Published var groupSession: GroupSession?
    
    private init() {}
}
