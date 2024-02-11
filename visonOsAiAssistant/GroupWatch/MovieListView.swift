//
//  MovieListView.swift
//  visonOsAiAssistant
//
//  Created by lily liao on 2/10/24.
//
import SwiftUI
import Combine

// Assuming Library.shared.movies and CoordinationManager.shared are accessible
// and Movie is Identifiable or you have a way to uniquely identify each movie

struct MovieListView: View {
    @State private var selectedMovie: Movie?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    // This assumes Movie conforms to Identifiable or you provide a way to identify each movie
    private var movies: [Movie] {
        Library.shared.movies
    }

    var body: some View {
        NavigationView {
            List(movies) { movie in
                MovieRow(movie: movie)
                    .onTapGesture {
                        self.selectedMovie = movie
                        CoordinationManager.shared.prepareToPlay(movie)
                    }
                    .listRowBackground(self.selectedMovie == movie ? Color.selectedBackground : Color.clear)
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.large)
        }
        .environment(\.defaultMinListRowHeight, 70) // Customize row height if needed
        .background(backgroundColor)
    }

    private var backgroundColor: Color {
        let isCompact = horizontalSizeClass == .compact
        return isCompact ? Color.contentBackground : Color.baseBackground
    }
}

struct MovieRow: View {
    var movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            Text(movie.title)
                .font(.headline)
                .foregroundColor(Color(white: 0.95))
            Text(movie.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(3)
        }
        .padding()
    }
}

extension Color {
    static let contentBackground = Color("ContentBackground")
    static let baseBackground = Color("BaseBackground")
    static let highlightedBackground = Color("HighlightedBackground")
    static let selectedBackground = Color("SelectedBackground")
}

struct Movie: Identifiable {
    let id: UUID = UUID()
    let title: String
    let description: String
    // Add other properties as needed
}

// Assuming Library and CoordinationManager are accessible and adapted as needed
class Library {
    static let shared = Library()
    var movies: [Movie] = [
        // Your movies here
    ]
}

class CoordinationManager {
    static let shared = CoordinationManager()
    func prepareToPlay(_ movie: Movie) {
        // Implement your playback preparation logic here
    }
}
