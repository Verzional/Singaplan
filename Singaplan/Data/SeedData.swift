//
//  SeedData.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

struct SeedData {
    // MARK: - Categories
    // Parent Categories
    static let nature = Category(title: "Nature & Outdoors")
    static let culture = Category(title: "Culture & History")
    static let metro = Category(title: "Metropolitan")
    static let supernatural = Category(title: "Supernatural")
    static let culinary = Category(title: "Culinary")
    
    // Subcategories
    static let categories: [Category] = [
        Category(title: "Mountain", icon: "mountain.2", parent: nature),
        Category(title: "Marine", icon:"water.waves", parent: nature),
        Category(title: "Wildlife", icon: "pawprint", parent: nature),
        Category(title: "Forest", icon: "tree", parent: nature),
        Category(title: "Artistic", icon: "paintpalette", parent: culture),
        Category(title: "Ancient", icon: "laurel.leading.laurel.trailing", parent: culture),
        Category(title: "Festive", icon: "party.popper", parent: culture),
        Category(title: "Mega City", icon: "building.2", parent: metro),
        Category(title: "Smart City", icon: "antenna.radiowaves.left.and.right", parent: metro),
        Category(title: "Celestial", icon: "sparkles", parent: supernatural),
        Category(title: "Spiritual", icon: "hands.and.sparkles", parent: supernatural),
        Category(title: "Fine Dining", icon:"fork.knife", parent: culinary),
        Category(title: "Street Food", icon:"flame", parent: culinary)
    ]
    
    // Combination
    static var categoryData: [Category] {
        return [nature, culture, metro, supernatural, culinary] + categories
    }
    
    //MARK: - Priorities
    static let experiences: [Priority] = [
        Priority(
            title: "Popularity",
            desc: "Balance your trip between world-renowned icons and under-the-radar local secrets.",
            segments: [
                PrioritySegment(label: "Hidden Gems", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "Iconic Hits", weight: 1.0)
            ]
        ),
        Priority(
            title: "Proximity",
            desc: "Prioritize areas with high concentrations of things to do, or spread out for a more spacious journey.",
            segments: [
                PrioritySegment(label: "Spaced Out", weight: 0.1),
                PrioritySegment(label: "Balanced", weight: 0.5),
                PrioritySegment(label: "Action-Packed", weight: 1.0)
            ]
        ),
        Priority(
            title: "Pace",
            desc: "Weight your day toward quick, high-variety 'snapshots' or deeper, time-intensive immersions.",
            segments: [
                PrioritySegment(label: "Snapshots", weight: 0.1),
                PrioritySegment(label: "Steady", weight: 0.5),
                PrioritySegment(label: "Deep Dives", weight: 1.0)
            ]
        )
    ]
    
    static let accessibility: [Priority] = [
        Priority(
            title: "Mobility", 
            desc: "Prioritize level, easy-access paths or embrace more rugged, adventurous surfaces.",
            segments: [
                PrioritySegment(label: "Rugged", weight: 0.1),
                PrioritySegment(label: "Standard", weight: 0.5),
                PrioritySegment(label: "Seamless", weight: 1.0)
            ]
        ),
        Priority(
            title: "Transport",
            desc: "Choose between secluded spots with one way in or vibrant hubs with every way to arrive.",
            segments: [
                PrioritySegment(label: "Single", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "Versatile", weight: 1.0)
            ]
        ),
        Priority(
            title: "Walkability",
            desc: "Balance your trip between vehicle-heavy roads and pedestrian-first zones with tram lines.",
            segments: [
                PrioritySegment(label: "Vehicle", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "Pedestrian", weight: 1.0)
            ]
        )
    ]
    
    // Combination
    static var priorityData: [Priority] {
        return experiences + accessibility
    }
}
