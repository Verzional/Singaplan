//
//  CategoryViewModel.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import Foundation
import SwiftData
import Observation

@Observable
final class CategoryViewModel {
    public var modelContext: ModelContext
    
    var mainCategories: [CategoryModel] = []
    var selectedCategories: Set<CategoryModel> = []
    var searchText: String = ""
    
    init(modelContext: ModelContext, initialSelectedCategories: [CategoryModel] = []) {
        self.modelContext = modelContext
        self.selectedCategories = Set(initialSelectedCategories)
        fetchData()
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
    
    func toggle(_ category: CategoryModel) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}
