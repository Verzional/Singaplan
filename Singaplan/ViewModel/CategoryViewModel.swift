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

    var mainCategories: [CategoryModel] = []
    var selectedCategories: Set<CategoryModel> = []
    var searchText: String = ""

    // MARK: - Init
    init(modelContext: ModelContext, initialSelectedCategories: [CategoryModel] = []) {
        self.modelContext = modelContext
        self.selectedCategories = Set(initialSelectedCategories)
        fetchData()
    }

    func fetchData() {
        let descriptor = FetchDescriptor<CategoryModel>(
            predicate: #Predicate { $0.parent == nil },
            sortBy: [SortDescriptor(\.title)]
        )
        do {
            self.mainCategories = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed: \(error)")
        }
    }
    
    var filteredCategories: [CategoryModel] {
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

    func toggle(_ category: CategoryModel) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}
