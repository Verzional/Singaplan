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
    // MARK: - Priorities
    // Define the Priorities
    static let budget = PriorityModel(title: "Budget", weight: 0.34)
    static let accessibility = PriorityModel(title: "Accessibility", weight: 0.33)
    static let experience = PriorityModel(title: "Experience", weight: 0.33)
    
    // Define the SubPriorities
    static let priorities: [PriorityModel] = [
        PriorityModel(title: "DBR Bracket", weight: 0.1, parent: budget),
        PriorityModel(title: "Additional Fees", weight: 0.1, parent: budget),
        PriorityModel(title: "Density of Interest", weight: 0.1, parent: experience)
    ]
    
    // Return the Categories with it's SubPriorities
    static var priorityData: [PriorityModel] {
        return [budget, accessibility, experience] + priorities
    }
    //MARK: - Experience
    static let experiences: [ExperienceModel] = [
        ExperienceModel(
            title: "Popularity",
            desc: "Balance your trip between world-renowned icons and under-the-radar local secrets.",
            segments: [
                ExperienceSegment(label: "Hidden Gems", weight: 0.1),
                ExperienceSegment(label: "Mixed", weight: 0.5),
                ExperienceSegment(label: "Iconic Hits", weight: 1.0)
            ]
        ),
        ExperienceModel(
            title: "Proximity",
            desc: "Prioritize areas with high concentrations of things to do, or spread out for a more spacious journey.",
            segments: [
                ExperienceSegment(label: "Spaced Out", weight: 0.1),
                ExperienceSegment(label: "Balanced", weight: 0.5),
                ExperienceSegment(label: "Action-Packed", weight: 1.0)
            ]
        ),
        ExperienceModel(
            title: "Pace",
            desc: "Weight your day toward quick, high-variety 'snapshots' or deeper, time-intensive immersions.",
            segments: [
                ExperienceSegment(label: "Snapshots", weight: 0.1),
                ExperienceSegment(label: "Steady", weight: 0.5),
                ExperienceSegment(label: "Deep Dives", weight: 1.0)
            ]
        )
    ]
}
