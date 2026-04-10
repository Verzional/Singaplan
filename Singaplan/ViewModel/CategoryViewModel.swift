//
//  CategoryViewModel.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class CategoryViewModel {
    private var modelContext: ModelContext

    var mainCategories: [Category] = []
    var selectedCategories: Set<Category> = []
    var searchText: String = ""

    // MARK: - Init
    init(modelContext: ModelContext, initialSelectedCategories: [Category] = []) {
        self.modelContext = modelContext
        self.selectedCategories = Set(initialSelectedCategories)
        fetchData()
    }

    func fetchData() {
        let descriptor = FetchDescriptor<Category>(
            predicate: #Predicate { $0.parent == nil },
            sortBy: [SortDescriptor(\.title)]
        )
        do {
            self.mainCategories = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed: \(error)")
        }
    }
    
    var filteredCategories: [Category] {
        if searchText.isEmpty {
            return mainCategories
        } else {
            return mainCategories.filter { parent in
                let matchesParent = parent.title.localizedCaseInsensitiveContains(searchText)
                let matchesChild = parent.subCategories.contains { child in
                    child.title.localizedCaseInsensitiveContains(searchText)
                }
                return matchesParent || matchesChild
            }
        }
    }

    func toggle(_ category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}
