//
//  MovieInfoView.swift
//  visonOsAiAssistant
//
//  Created by lily liao on 2/10/24.
//
import SwiftUI
import Combine

struct MovieInfoView: View {
    @ObservedObject private var coordinationManager = CoordinationManager.shared
    @State private var movie: Movie?

    init() {
        // Subscribe to movie updates from CoordinationManager
        _movie = State(initialValue: coordinationManager.enqueuedMovie)
    }

    var body: some View {
        VStack(alignment: .leading) {
            if let movie = movie {
                Text(movie.title)
                    .font(.title2)
                    .foregroundColor(Color(white: 0.95))
                    .padding(.bottom, 8)
                
                Text(movie.description)
                    .font(.body)
                    .foregroundColor(Color(white: 0.7))
                    .padding(.bottom, 8)
            } else {
                Text("Select a movie to see its details")
                    .foregroundColor(Color.gray)
            }
        }
        .padding()
        .onReceive(coordinationManager.$enqueuedMovie) { movie in
            self.movie = movie
        }
    }
}

// Assuming the CoordinationManager and Movie classes are defined as follows:
class CoordinationManager: ObservableObject {
    static let shared = CoordinationManager()
    @Published var enqueuedMovie: Movie?
}

