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
    private var modelContext: ModelContext
    
    var mainCategories: [CategoryModel] = []
    var selectedCategories: Set<CategoryModel> = []

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
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

    func toggle(_ category: CategoryModel) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}
