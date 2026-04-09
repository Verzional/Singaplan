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
    @Attribute(.unique) var id: String
    var name: String
    var desc: String
    var location: String

    // Relasi ke model lainnya
    var district: District?
    var subcategory: CategoryModel?
    var itineraryDay: ItineraryDay?
    
    @Relationship(deleteRule: .cascade)
    var photos: [Photo] = []
    
    init(id: String, name: String, desc: String, location: String, district: District? = nil, subcategory: CategoryModel? = nil, photo: Photo? = nil) {
        self.id = id
        self.name = name
        self.desc = desc
        self.location = location
        self.district = district
        self.subcategory = subcategory
        if let photo = photo {
            self.photos = [photo]
        }
    }
}
