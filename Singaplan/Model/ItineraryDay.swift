//
//  ItineraryDay.swift
//  Singaplan
//
//  Created by Sherin Alvinia Yonatan on 06/04/26.
//

import Foundation
import SwiftData

@Model
final class ItineraryDay {
    @Attribute(.unique) var id: UUID
    var dayNumber: Int
    
    @Relationship(deleteRule: .cascade, inverse: \POI.itineraryDay)
    var destinations: [POI] = []
    
    @Relationship(deleteRule: .nullify)
    var plannedDistricts: [District] = []
    
    init(dayNumber: Int) {
        self.id = UUID()
        self.dayNumber = dayNumber
    }
}

