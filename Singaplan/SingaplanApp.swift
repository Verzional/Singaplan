//
//  SingaplanApp.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

@main
struct SingaplanApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
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
}
