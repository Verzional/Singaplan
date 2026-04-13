//
//  ContentView.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ItineraryView()
            .task {
                seedDataIfNeeded()
            }
    }
    
    private func seedDataIfNeeded() {
        do {
            var descriptor = FetchDescriptor<Category>()
            descriptor.fetchLimit = 1
            
            if try modelContext.fetch(descriptor).isEmpty {
                for category in SeedData.categoryData {
                    modelContext.insert(category)
                }
                
                for priority in SeedData.priorityData {
                    modelContext.insert(priority)
                }
                
                for district in SeedData.districtData {
                    modelContext.insert(district)
                }
                
                for poi in SeedData.poiData {
                    modelContext.insert(poi)
                }
                
                try? modelContext.save()
            }
        } catch {
            print("Failed to fetch or seed data: \(error)")
        }
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
