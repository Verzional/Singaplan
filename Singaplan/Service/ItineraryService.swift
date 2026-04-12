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
}
