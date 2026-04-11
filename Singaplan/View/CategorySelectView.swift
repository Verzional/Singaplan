//
//  CategoryCreate.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct CategorySelectView: View {
    // MARK: - File Properties
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedCategories: Set<Category>
    @State private var searchText: String = ""
    @State private var isShowingSaveModal = false
    
    @Query(filter: #Predicate<Category> { $0.parent == nil }, sort: \Category.title)
    private var mainCategories: [Category]

    private let presetToEdit: CategoryPreset?
    
    init(preset: CategoryPreset? = nil) {
        self.presetToEdit = preset
        self._selectedCategories = State(initialValue: Set(preset?.categories ?? []))
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
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search categories...")
                    .padding(.vertical)
                categorySection
            }
            .navigationTitle(presetToEdit == nil ? "Select Categories" : "Edit Categories")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                navigationToolbar
            }
            .sheet(isPresented: $isShowingSaveModal) {
                CategorySaveView(
                    preset: presetToEdit,
                    selectedCategories: Array(selectedCategories), // Updated reference
                    onSaveComplete: { dismiss() }
                )
            }
        }
    }
}

// MARK: - View Components
extension CategorySelectView {
    fileprivate var categorySection: some View{
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(filteredCategories) { parent in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(parent.title)
                            .font(.headline)
                            .padding(.horizontal)
                        
                        FlowLayout {
                            ForEach(parent.subCategories) { child in
                                CategoryCapsule(
                                    child: child,
                                    isSelected: selectedCategories.contains(child)
                                )
                                .onTapGesture {
                                    toggle(child)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    fileprivate var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Next") {
                    isShowingSaveModal = true
                }
            }
        }
    }
}

// MARK: - View Functions
extension CategorySelectView {
    fileprivate func toggle(_ category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}

// MARK: - Preview
#Preview {
    // 1. Setup In-Memory Container
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, configurations: config)
    
    // 2. Inject Seed Data
    let context = container.mainContext
    for category in SeedData.categoryData {
        context.insert(category)
    }
    
    // 3. Return View (Removed modelContext parameter)
    return CategorySelectView()
        .modelContainer(container)
}

