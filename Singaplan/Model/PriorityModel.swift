//
//  Priority.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import Foundation
import SwiftData

@Model
final class PriorityModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var weight: Double
    var parent: PriorityModel?
    
    @Relationship(deleteRule: .cascade, inverse: \PriorityModel.parent)
    var subPriorities: [PriorityModel] = []
    
    init(id: UUID = UUID(), title: String, weight: Double, parent: PriorityModel? = nil) {
        self.id = id
        self.title = title
        self.weight = weight
        self.parent = parent
    }
}
