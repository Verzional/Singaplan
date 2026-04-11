//
//  Category.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import Foundation
import SwiftData

@Model
final class Category {
    @Attribute(.unique) var id: UUID
    var title: String
    var icon: String?
    var parent: Category?
    
    @Relationship(deleteRule: .cascade, inverse: \Category.parent)
    var subCategories: [Category] = []
    
    init(
        id: UUID = UUID(),
        title: String,
        icon: String? = nil,
        parent: Category? = nil
    ) {
        self.id = id
        self.title = title
        self.icon = icon
        self.parent = parent
    }
}
