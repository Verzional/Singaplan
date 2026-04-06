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
    var title: String
    var desc: String?
    
    @Relationship(deleteRule: .noAction)
    var categories: [CategoryModel] = []
    
    init(title: String, desc: String, categories: [CategoryModel] = []) {
        self.title = title
        self.desc = desc
        self.categories = categories
    }
}
