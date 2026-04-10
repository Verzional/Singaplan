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
    @Attribute(.unique) var id: String
    var name: String
    var address: String
    var desc: String
    var photoUrl: String
    
    @Relationship(deleteRule: .nullify, inverse: \POI.district)
    var pois: [POI] = []

    init(id: String, name: String, address: String, desc: String, photoUrl: String) {
        self.id = id
        self.name = name
        self.address = address
        self.desc = desc
        self.photoUrl = photoUrl
    }
}
