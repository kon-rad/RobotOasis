//
//  EventList.swift
//  visonOsAiAssistant
//
//  Created by Konrad Gnat on 2/10/24.
//

import Foundation

import SwiftUI

struct EventsListView: View {
    // Sample events
    let events = [
        Event(title: "Robotics Workshop", description: "Learn about robotics.", startTime: "10:00 AM"),
        Event(title: "AI Seminar", description: "Dive into AI advancements.", startTime: "1:00 PM")
    ]

    var body: some View {
        List(events, id: \.title) { event in
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.headline)
                Text(event.description)
                    .font(.subheadline)
                Text("Start time: \(event.startTime)")
                    .font(.caption)
                
                HStack {
                    Button("Join") {
                        // Handle join action
                        print("Join tapped for \(event.title)")
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Details") {
                        // Handle details action
                        print("Details tapped for \(event.title)")
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.top, 5)
            }
            .padding()
        }
    }
}

struct EventsListView_Previews: PreviewProvider {
    static var previews: some View {
        EventsListView()
    }
}
