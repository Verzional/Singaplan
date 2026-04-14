//
//  ItineraryService.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 12/04/26.
//

import Foundation
import SwiftData

class ItineraryService {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Core Add Methods
    
    func addDistrict(_ district: District, to day: ItineraryDay) {
        guard !day.plannedDistricts.contains(where: { $0.id == district.id }) else {
            print("District is already planned for this day.")
            return
        }
        
        day.plannedDistricts.append(district)
        
        do {
            try modelContext.save()
            print("Successfully added District: \(district.name) to Day \(day.dayNumber)")
        } catch {
            print("Failed to save district to itinerary day: \(error.localizedDescription)")
        }
    }
    
    func addPOI(_ poi: POI, to day: ItineraryDay) {
        guard !day.destinations.contains(where: { $0.id == poi.id }) else {
            print("POI is already added to this day.")
            return
        }
        
        poi.itineraryDay = day
        day.destinations.append(poi)
        
        if let district = poi.district, !day.plannedDistricts.contains(where: { $0.id == district.id }) {
            day.plannedDistricts.append(district)
        }
        
        do {
            try modelContext.save()
            print("Successfully added POI: \(poi.name) to Day \(day.dayNumber)")
        } catch {
            print("Failed to save POI to itinerary day: \(error.localizedDescription)")
        }
    }
    
    func addDistrict(_ district: District, to itinerary: Itinerary, dayNumber: Int) {
        guard let targetDay = itinerary.days.first(where: { $0.dayNumber == dayNumber }) else {
            print("Day \(dayNumber) not found in Itinerary.")
            return
        }
        addDistrict(district, to: targetDay)
    }
    
    func addPOI(_ poi: POI, to itinerary: Itinerary, dayNumber: Int) {
        guard let targetDay = itinerary.days.first(where: { $0.dayNumber == dayNumber }) else {
            print("Day \(dayNumber) not found in Itinerary.")
            return
        }
        addPOI(poi, to: targetDay)
    }
    
    // MARK: - Recommendation Methods
    
    /// Filters and returns the top 3 Districts based on the provided Category and Priority presets.
    func getTopRecommendedDistricts(categoryPreset: CategoryPreset, priorityPreset: PriorityPreset) -> [District] {
        let descriptor = FetchDescriptor<District>()
        guard let allDistricts = try? modelContext.fetch(descriptor) else {
            return []
        }
        
        let scoredDistricts = allDistricts.map { district -> (district: District, score: Double) in
            let score = calculateCompatibilityScore(
                entityCategories: district.categories ?? [],
                entityPriorities: district.priorities ?? [],
                categoryPreset: categoryPreset,
                priorityPreset: priorityPreset
            )
            return (district, score)
        }
        
        // Sort descending by score, then take the top 3
        return scoredDistricts
            .sorted { $0.score > $1.score }
            .prefix(3)
            .map { $0.district }
    }
    
    /// Filters and returns the top 3 POIs within a specific District based on the provided presets.
    func getTopRecommendedPOIs(for district: District, categoryPreset: CategoryPreset, priorityPreset: PriorityPreset) -> [POI] {
        // Fetch all POIs associated with the district
        let districtPOIs = district.pois
        
        let scoredPOIs = districtPOIs.map { poi -> (poi: POI, score: Double) in
            let score = calculateCompatibilityScore(
                entityCategories: poi.categories ?? [],
                entityPriorities: poi.priorities ?? [],
                categoryPreset: categoryPreset,
                priorityPreset: priorityPreset
            )
            return (poi, score)
        }
        
        // Sort descending by score, then take the top 3
        return scoredPOIs
            .sorted { $0.score > $1.score }
            .prefix(3)
            .map { $0.poi }
    }
    
    /// Calculates a normalized score between 0.0 and 1.0 based on how well an entity matches the presets
    private func calculateCompatibilityScore(
        entityCategories: [Category],
        entityPriorities: [Priority],
        categoryPreset: CategoryPreset,
        priorityPreset: PriorityPreset
    ) -> Double {
        
        // 1. Calculate Category Score (Weight: 50% of total)
        var categoryScore = 0.0
        let presetCategories = categoryPreset.categories
        
        if !presetCategories.isEmpty {
            let presetCategoryIds = Set(presetCategories.map { $0.id })
            let entityCategoryIds = Set(entityCategories.map { $0.id })
            
            // Number of categories the user wanted that are actually in the entity
            let matchCount = presetCategoryIds.intersection(entityCategoryIds).count
            categoryScore = Double(matchCount) / Double(presetCategories.count)
        } else {
            // If the user didn't select any categories, it doesn't negatively impact the score
            categoryScore = 1.0
        }
        
        // 2. Calculate Priority Score (Weight: 50% of total)
        var priorityScore = 0.0
        let presetPriorities = priorityPreset.priorities
        
        if !presetPriorities.isEmpty {
            var totalPriorityMatch = 0.0
            
            // Map entity priorities by title for O(1) lookup
            let entityPriorityDict = Dictionary(uniqueKeysWithValues: entityPriorities.map { ($0.title, $0) })
            
            for presetPriority in presetPriorities {
                if let matchedEntityPriority = entityPriorityDict[presetPriority.title] {
                    // Difference between selected weights (0.0 to 1.0 range in your seed data)
                    let weightDifference = abs(presetPriority.selectedWeight - matchedEntityPriority.selectedWeight)
                    
                    // The closer the weight, the higher the similarity score (Max 1.0)
                    let similarity = max(0.0, 1.0 - weightDifference)
                    totalPriorityMatch += similarity
                }
            }
            
            // Average priority match across all requested priorities
            priorityScore = totalPriorityMatch / Double(presetPriorities.count)
        } else {
            // If the user didn't select any priorities, it doesn't negatively impact the score
            priorityScore = 1.0
        }
        
        // Return average of both scores
        return (categoryScore + priorityScore) / 2.0
    }
}
