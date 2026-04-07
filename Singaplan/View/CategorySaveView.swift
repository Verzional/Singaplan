//
//  CategorySaveView.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftData
import SwiftUI

struct CategorySaveView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var description: String = ""

    let selectedCategories: [CategoryModel]

    let presetToEdit: CategoryPreset?
    var onSaveComplete: () -> Void

    init(
        preset: CategoryPreset? = nil, selectedCategories: [CategoryModel],
        onSaveComplete: @escaping () -> Void
    ) {
        self.presetToEdit = preset
        self.selectedCategories = selectedCategories
        self.onSaveComplete = onSaveComplete

        self._name = State(initialValue: preset?.title ?? "")
        self._description = State(initialValue: preset?.desc ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Preset Details") {
                    TextField("Name (e.g., Weekend Trip)", text: $name)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...5)
                }

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
            .navigationTitle(presetToEdit == nil ? "Save Preset" : "Edit Preset")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        savePreset()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }

    private func savePreset() {
        if let existingPreset = presetToEdit {
            existingPreset.title = name
            existingPreset.desc = description
            existingPreset.categories = selectedCategories
        } else {
            let newPreset = CategoryPreset(
                title: name,
                desc: description,
                categories: selectedCategories
            )
            modelContext.insert(newPreset)
        }

        dismiss()
        onSaveComplete()
    }
}

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
