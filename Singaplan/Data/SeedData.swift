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
        CategoryModel(title: "Mountain", icon: "􁗝", parent: nature),
        CategoryModel(title: "Marine", icon:"􁎄", parent: nature),
        CategoryModel(title: "Wildlife", icon: "􀾞", parent: nature),
        CategoryModel(title: "Artistic", icon: "􀝥", parent: culture),
        CategoryModel(title: "Ancient", icon: "􂶟", parent: culture),
        CategoryModel(title: "Festive", icon: "􁓵", parent: culture),
        CategoryModel(title: "Mega City", icon: "􀝒", parent: metro),
        CategoryModel(title: "Smart City", icon: "􀖀", parent: metro),
        CategoryModel(title: "Celestial", icon: "􀆿", parent: supernatural),
        CategoryModel(title: "Spiritual", icon: "􀲮", parent: supernatural),
        CategoryModel(title: "Fine Dining", icon:"􀸩", parent: culinary),
        CategoryModel(title: "Street Food", icon:"􀙬", parent: culinary)
    ]
    
    static var categoryData: [CategoryModel] {
        return [nature, culture, metro, supernatural, culinary] + categories
    }
}
