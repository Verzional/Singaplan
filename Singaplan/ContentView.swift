//
//  ContentView.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        ItineraryView()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Category.self,
        CategoryPreset.self,
        District.self,
        ItineraryDay.self,
        Itinerary.self,
        POI.self,
        Priority.self,
        PriorityPreset.self,
        configurations: config
    )
    
    return ContentView()
        .modelContainer(container)
}
