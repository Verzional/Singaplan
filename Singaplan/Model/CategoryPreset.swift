//
//  CategoryPreset.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import Foundation
import SwiftData

@Model
final class CategoryPreset {
    @Attribute(.unique) var id: UUID
    var title: String
    var desc: String?
    var createdAt: Date
    
    @Relationship(deleteRule: .noAction)
    var categories: [Category] = []
    
    init(id: UUID = UUID(), title: String, desc: String, categories: [Category] = [], createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.desc = desc
        self.categories = categories
        self.createdAt = createdAt
    }
}
