//
//  CategorySaveView.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct CategorySaveView: View {
    //MARK: - File Properties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // State Properties
    @State private var presetTitle: String = ""
    @State private var presetDescription: String = ""
    
    // Local Variables
    let selectedCategories: [CategoryModel]
    let presetToEdit: CategoryPreset?
    let onSaveComplete: () -> Void
    
    init(
        preset: CategoryPreset? = nil, selectedCategories: [CategoryModel],
        onSaveComplete: @escaping () -> Void
    ) {
        self.presetToEdit = preset
        self.selectedCategories = selectedCategories
        self.onSaveComplete = onSaveComplete
        
        self._presetTitle = State(initialValue: preset?.title ?? "")
        self._presetDescription = State(initialValue: preset?.desc ?? "")
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                detailsSection
                categoriesSection
            }
            .navigationTitle(presetToEdit == nil ? "Save Preset" : "Edit Preset")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                navigationToolbar
            }
        }
    }
}

// MARK: - View Components
private extension CategorySaveView {
    var detailsSection: some View {
        Section("Preset Details") {
            TextField("Name (e.g., Weekend Trip)", text: $presetTitle)
            TextField("Description", text: $presetDescription, axis: .vertical)
                .lineLimit(3...5)
        }
    }
    var categoriesSection: some View {
        Section("Selected Categories") {
            FlowLayout {
                ForEach(selectedCategories) { category in
                    CategoryCapsule(child: category, isSelected: true)
                }
            }
            .padding(.vertical, 8)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
        }
    }
    
    var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    savePreset()
                } label: {
                    Image(systemName: "checkmark")
                }
                .disabled(presetTitle.isEmpty)
            }
        }
    }
    
    func savePreset() {
        if let existingPreset = presetToEdit {
            existingPreset.title = presetTitle
            existingPreset.desc = presetDescription.isEmpty ? nil : presetDescription
            existingPreset.categories = selectedCategories
        } else {
            let newPreset = CategoryPreset(
                title: presetTitle,
                desc: presetDescription.isEmpty ? "" : presetDescription,
                categories: selectedCategories
            )
            modelContext.insert(newPreset)
        }
        
        dismiss()
        onSaveComplete()
    }
}

// MARK: - Preview
#Preview {
    // In Memory DB
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: CategoryPreset.self, CategoryModel.self, configurations: config)
    
    // Sample Data
    let sampleSelected = [
        CategoryModel(title: "Mountain", icon: "mountain.2"),
        CategoryModel(title: "Smart City", icon: "antenna.radiowaves.left.and.right"),
        CategoryModel(title: "Street Food", icon: "flame"),
        CategoryModel(title: "Beach", icon: "sun.max"),
    ]
    
    NavigationStack {
        CategorySaveView(
            preset: nil,
            selectedCategories: sampleSelected,
            onSaveComplete: {}
        )
    }
    .modelContainer(container)
}
