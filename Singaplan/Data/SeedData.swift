//
//  SeedData.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

struct SeedData {
    // MARK: - Categories
    // Define the Categories
    static let nature = CategoryModel(title: "Nature & Outdoors")
    static let culture = CategoryModel(title: "Culture & History")
    static let metro = CategoryModel(title: "Metropolitan")
    static let supernatural = CategoryModel(title: "Supernatural")
    static let culinary = CategoryModel(title: "Culinary")
    
    // Define the SubCategories
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
    
    // Return the Categories with it's SubCategories
    static var categoryData: [CategoryModel] {
        return [nature, culture, metro, supernatural, culinary] + categories
    }
    
    //MARK: - Priorities
    static let experiences: [PriorityModel] = [
        PriorityModel(
            title: "Popularity",
            desc: "Balance your trip between world-renowned icons and under-the-radar local secrets.",
            segments: [
                PrioritySegment(label: "Hidden Gems", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "Iconic Hits", weight: 1.0)
            ]
        ),
        PriorityModel(
            title: "Proximity",
            desc: "Prioritize areas with high concentrations of things to do, or spread out for a more spacious journey.",
            segments: [
                PrioritySegment(label: "Spaced Out", weight: 0.1),
                PrioritySegment(label: "Balanced", weight: 0.5),
                PrioritySegment(label: "Action-Packed", weight: 1.0)
            ]
        ),
        PriorityModel(
            title: "Pace",
            desc: "Weight your day toward quick, high-variety 'snapshots' or deeper, time-intensive immersions.",
            segments: [
                PrioritySegment(label: "Snapshots", weight: 0.1),
                PrioritySegment(label: "Steady", weight: 0.5),
                PrioritySegment(label: "Deep Dives", weight: 1.0)
            ]
        )
    ]
    
    static let accessibility: [PriorityModel] = [
        PriorityModel(
            title: "Mobility", 
            desc: "Prioritize level, easy-access paths or embrace more rugged, adventurous surfaces.",
            segments: [
                PrioritySegment(label: "Rugged", weight: 0.1),
                PrioritySegment(label: "Standard", weight: 0.5),
                PrioritySegment(label: "Seamless", weight: 1.0)
            ]
        ),
        PriorityModel(
            title: "Transport",
            desc: "Choose between secluded spots with one way in or vibrant hubs with every way to arrive.",
            segments: [
                PrioritySegment(label: "Single", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "Versatile", weight: 1.0)
            ]
        ),
        PriorityModel(
            title: "Walkability",
            desc: "Balance your trip between vehicle-heavy roads and pedestrian-first zones with tram lines.",
            segments: [
                PrioritySegment(label: "Vehicle", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "Pedestrian", weight: 1.0)
            ]
        )
    ]
    
    static var priorityData: [PriorityModel] {
        return experiences + accessibility
    }
}
