//
//  PriorityPreset.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 07/04/26.
//

import Foundation
import SwiftData

@Model
final class PriorityPreset {
    @Attribute(.unique) var id: UUID
    var title: String
    var desc: String?
    
    @Relationship(deleteRule: .noAction)
    var priorities: [PriorityModel] = []
    
    init(id: UUID = UUID(), title: String, desc: String? = nil, prioties: [PriorityModel] = []) {
        self.id = id
        self.title = title
        self.desc = desc
        self.priorities = prioties
    }
}
