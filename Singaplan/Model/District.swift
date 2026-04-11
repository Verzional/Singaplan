//
//  District.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import Foundation
import SwiftData

@Model
final class District {
    @Attribute(.unique) var id: UUID
    var name: String
    var address: String
    var desc: String
    var openTime: String?
    var closeTime: String?
    var photoUrls: [String]
    
    @Relationship(deleteRule: .nullify)
    var priorities: [Priority]? = []
        
    @Relationship(deleteRule: .nullify)
    var categories: [Category]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \POI.district)
    var pois: [POI] = []
    
    init(
        id: UUID = UUID(),
        name: String,
        address: String,
        desc: String,
        openTime: String? = nil,
        closeTime: String? = nil,
        photoUrls: [String],
        priorities: [Priority]? = nil,
        categories: [Category]? = nil
    ) {
        self.id = id
        self.name = name
        self.address = address
        self.desc = desc
        self.openTime = openTime
        self.photoUrls = photoUrls
        self.closeTime = closeTime
        self.priorities = priorities
        self.categories = categories
    }
}
