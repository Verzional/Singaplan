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
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for:
                Category.self,
                CategoryPreset.self,
                District.self,
                ItineraryDay.self,
                Itinerary.self,
                POI.self,
                Priority.self,
                PriorityPreset.self
            )
            
            let context = ModelContext(container)
            
            var categoryFetchDescriptor = FetchDescriptor<Category>()
            categoryFetchDescriptor.fetchLimit = 1
            
            if try context.fetch(categoryFetchDescriptor).isEmpty {
                for category in SeedData.categoryData {
                    context.insert(category)
                }
                
                for priority in SeedData.priorityData {
                    context.insert(priority)
                }
                
                try context.save()
            }
            
        } catch {
            fatalError("Failed to initialize ModelContainer or seed data: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }   
        .modelContainer(container)
    }
}
