//
//  POI.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import Foundation
import SwiftData

@Model
final class POI {
    @Attribute(.unique) var id: UUID
    var name: String
    var desc: String
    var address: String
    var openTime: String?
    var closeTime: String?
    
    var district: District?
    var itineraryDay: ItineraryDay?
    
    @Relationship(deleteRule: .nullify)
    var priorities: [Priority]? = []
    
    @Relationship(deleteRule: .nullify)
    var categories: [Category]? = []
    
    @Relationship(deleteRule: .cascade)
    var photoUrls: [String]

    init(
        id: UUID = UUID(),
        name: String,
        desc: String,
        address: String,
        photoUrls: [String],
        openTime: String? = nil,
        closeTime: String? = nil,
        district: District? = nil,
        priorities: [Priority]? = nil,
        categories: [Category]? = nil
    ) {
        self.id = id
        self.name = name
        self.desc = desc
        self.address = address
        self.photoUrls = photoUrls
        self.openTime = openTime
        self.closeTime = closeTime
        self.district = district
        self.priorities = priorities
        self.categories = categories
    }
}
