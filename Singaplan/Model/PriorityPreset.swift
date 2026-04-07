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
    var title: String
    var desc: String?
    var createdAt: Date
    
    @Relationship(deleteRule: .noAction)
    var priorities: [PriorityModel] = []
    
    init(title: String, desc: String? = nil, priorities: [PriorityModel] = [], createdAt: Date = Date()) {
        self.title = title
        self.desc = desc
        self.priorities = priorities
        self.createdAt = createdAt
    }
}
