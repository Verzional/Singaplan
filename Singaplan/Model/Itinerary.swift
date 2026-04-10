//
//  ItineraryFolder.swift
//  Singaplan
//
//  Created by Sherin Alvinia Yonatan on 09/04/26.
//

import Foundation
import SwiftData

@Model
final class Itinerary {
    @Attribute(.unique) var id: UUID
    var folderName: String
    
    @Relationship(deleteRule: .cascade, inverse: \ItineraryDay.itineraryFolder)
    var days: [ItineraryDay] = []
    
    init(folderName: String) {
        self.id = UUID()
        self.folderName = folderName
    }
}
