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
    var createdAt: Date
    
    @Relationship(deleteRule: .noAction)
    var priorities: [Priority] = []
    
    init(
        id: UUID = UUID(),
        title: String,
        desc: String? = nil,
        priorities: [Priority] = [],
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.desc = desc
        self.priorities = priorities
        self.createdAt = createdAt
    }
}
