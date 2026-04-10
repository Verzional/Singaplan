//
//  PriorityViewModel.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 07/04/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class PriorityViewModel {
    private var modelContext: ModelContext
    
    // Priorities
    var experiences: [Priority]
    var accessibility: [Priority]

    // Budget
    var selectedBracket: String = "$$"
    var entryFee: Bool = false

    // All Priorities
    var allPriorities: [Priority] {
        experiences + accessibility
    }

    // MARK: - Init
    init(modelContext: ModelContext, preset: PriorityPreset? = nil) {
        self.modelContext = modelContext

        if let preset = preset {
            let expTitles = SeedData.experiences.map(\.title)
            let accTitles = SeedData.accessibility.map(\.title)

            _ = Set(expTitles)
            _ = Set(accTitles)

            let presetByTitle = Dictionary(
                uniqueKeysWithValues: preset.priorities.map { ($0.title, $0) }
            )

            self.experiences = expTitles.compactMap { title -> Priority? in
                guard let source = presetByTitle[title] else { return nil }
                return PriorityViewModel.makeCopy(of: source)
            }

            self.accessibility = accTitles.compactMap { title -> Priority? in
                guard let source = presetByTitle[title] else { return nil }
                return PriorityViewModel.makeCopy(of: source)
            }

            if self.experiences.isEmpty {
                self.experiences = PriorityViewModel.freshCopies(of: SeedData.experiences)
            }
            if self.accessibility.isEmpty {
                self.accessibility = PriorityViewModel.freshCopies(of: SeedData.accessibility)
            }
        } else {
            self.experiences = PriorityViewModel.freshCopies(of: SeedData.experiences)
            self.accessibility = PriorityViewModel.freshCopies(of: SeedData.accessibility)
        }
    }

    private static func makeCopy(of source: Priority) -> Priority {
        let copy = Priority(
            title: source.title,
            desc: source.desc,
            segments: source.segments
        )
        copy.selectedWeight = source.selectedWeight
        return copy
    }

    private static func freshCopies(of templates: [Priority]) -> [Priority] {
        templates.map { source in
            Priority(
                title: source.title,
                desc: source.desc,
                segments: source.segments
            )
        }
    }
}
