//
//  ContentView.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        VStack {
            ItineraryView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [
            Category.self,
            CategoryPreset.self,
            District.self,
            ItineraryDay.self,
            Itinerary.self,
            POI.self,
            Priority.self,
            PriorityPreset.self
        ])
}

