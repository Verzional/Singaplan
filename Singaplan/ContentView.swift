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
            let descriptor = FetchDescriptor<District>()
            if try !modelContext.fetch(descriptor).isEmpty { return }

            var categoryMap: [String: Category] = [:]
            for categoryTemplate in SeedData.categoryData {
                let newCategory = Category(title: categoryTemplate.title, icon: categoryTemplate.icon)
                modelContext.insert(newCategory)
                categoryMap[newCategory.title] = newCategory
            }
            
            for categoryTemplate in SeedData.categoryData {
                if let parentTemplate = categoryTemplate.parent {
                    let current = categoryMap[categoryTemplate.title]
                    current?.parent = categoryMap[parentTemplate.title]
                }
            }
            
            try modelContext.save()

            var districtMap: [String: District] = [:]
            for districtTemplate in SeedData.districtData {
                let newDistrict = District(
                    name: districtTemplate.name,
                    address: districtTemplate.address,
                    desc: districtTemplate.desc,
                    photoUrls: districtTemplate.photoUrls
                )
                
                if let templateCats = districtTemplate.categories {
                    newDistrict.categories = templateCats.compactMap { categoryMap[$0.title] }
                }
                
                if let templatePriorities = districtTemplate.priorities {
                    newDistrict.priorities = templatePriorities.map { p in
                        let newP = Priority(title: p.title, desc: p.desc, segments: p.segments)
                        newP.selectedWeight = p.selectedWeight
                        return newP
                    }
                }
                
                modelContext.insert(newDistrict)
                districtMap[newDistrict.name] = newDistrict
            }

            try modelContext.save()

            for poiTemplate in SeedData.poiData {
                let newPOI = POI(
                    name: poiTemplate.name,
                    desc: poiTemplate.desc,
                    address: poiTemplate.address,
                    photoUrls: poiTemplate.photoUrls,
                    openTime: poiTemplate.openTime,
                    closeTime: poiTemplate.closeTime
                )
                
                if let templateDist = poiTemplate.district {
                    newPOI.district = districtMap[templateDist.name]
                }
                
                if let templateCats = poiTemplate.categories {
                    newPOI.categories = templateCats.compactMap { categoryMap[$0.title] }
                }
                
                modelContext.insert(newPOI)
            }
            
            try modelContext.save()
            print("✅ Seeding Success: All relationships stitched.")
            
        } catch {
            print("❌ Seeding Error: \(error)")
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
    
    ContentView()
        .modelContainer(container)
        .environment(FlowManager())
}
