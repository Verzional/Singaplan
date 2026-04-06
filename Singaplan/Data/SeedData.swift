//
//  SeedData.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

struct SeedData {
    static let nature = CategoryModel(title: "Nature & Outdoors")
    static let culture = CategoryModel(title: "Culture & History")
    static let metro = CategoryModel(title: "Metropolitan")
    static let supernatural = CategoryModel(title: "Supernatural")
    static let culinary = CategoryModel(title: "Culinary")
    
    static let categories: [CategoryModel] = [
        CategoryModel(title: "Mountain", icon: "mountain.2", parent: nature),
        CategoryModel(title: "Marine", icon:"water.waves", parent: nature),
        CategoryModel(title: "Wildlife", icon: "pawprint", parent: nature),
        CategoryModel(title: "Forest", icon: "tree", parent: nature),
        CategoryModel(title: "Artistic", icon: "paintpalette", parent: culture),
        CategoryModel(title: "Ancient", icon: "laurel.leading.laurel.trailing", parent: culture),
        CategoryModel(title: "Festive", icon: "party.popper", parent: culture),
        CategoryModel(title: "Mega City", icon: "building.2", parent: metro),
        CategoryModel(title: "Smart City", icon: "antenna.radiowaves.left.and.right", parent: metro),
        CategoryModel(title: "Celestial", icon: "sparkles", parent: supernatural),
        CategoryModel(title: "Spiritual", icon: "hands.and.sparkles", parent: supernatural),
        CategoryModel(title: "Fine Dining", icon:"fork.knife", parent: culinary),
        CategoryModel(title: "Street Food", icon:"flame", parent: culinary)
    ]
    
    static var categoryData: [CategoryModel] {
        return [nature, culture, metro, supernatural, culinary] + categories
    }
}
