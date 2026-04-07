//
//  CategoryCreate.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftData
import SwiftUI

struct CategorySelectView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: CategoryViewModel
    @State private var isShowingSaveModal = false

    private let presetToEdit: CategoryPreset?

    init(modelContext: ModelContext, preset: CategoryPreset? = nil) {
        self.presetToEdit = preset
        self._viewModel = State(
            initialValue: CategoryViewModel(
                modelContext: modelContext,
                initialSelectedCategories: preset?.categories ?? []
            )
        )
    }

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchText, placeholder: "Search categories...")
                    .padding(.vertical)

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(viewModel.filteredCategories) { parent in
                            VStack(alignment: .leading, spacing: 12) {
                                Text(parent.title)
                                    .font(.headline)
                                    .padding(.horizontal)

                                FlowLayout {
                                    ForEach(parent.subCategories) { child in
                                        CategoryCapsule(
                                            child: child,
                                            isSelected: viewModel.selectedCategories.contains(child)
                                        )
                                        .onTapGesture {
                                            viewModel.toggle(child)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingSaveModal = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle(presetToEdit == nil ? "Select Categories" : "Edit Categories")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingSaveModal) {
                CategorySaveView(
                    preset: presetToEdit,
                    selectedCategories: Array(viewModel.selectedCategories),
                    onSaveComplete: { dismiss() }
                )
            }
        }
    }
}

#Preview {
    // In Memory DB
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: CategoryModel.self, configurations: config)

    // Context
    let context = container.mainContext

    // Data Injection
    for category in SeedData.categoryData {
        context.insert(category)
    }

    // Return Preview
    return CategorySelectView(modelContext: context)
        .modelContainer(container)
}
