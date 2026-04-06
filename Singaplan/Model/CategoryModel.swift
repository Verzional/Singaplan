//
//  Category.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import Foundation
import SwiftData

@Model
final class CategoryModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var icon: String?
    var parent: CategoryModel?
    
    @Relationship(deleteRule: .cascade, inverse: \CategoryModel.parent)
    var subcategories: [CategoryModel] = []
    
    init(id: UUID = UUID(), title: String, icon: String? = nil, parent: CategoryModel? = nil) {
        self.id = id
        self.title = title
        self.icon = icon
        self.parent = parent
    }
}
