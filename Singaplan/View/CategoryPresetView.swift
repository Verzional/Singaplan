//
//  CategoryPreset.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftData
import SwiftUI

struct CategoryPresetView: View {
    // MARK: - File Properties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var presetToEdit: CategoryPreset?
    @State private var selectedPreset: UUID?
    @State private var isShowingSheet = false

    @Query(sort: \CategoryPreset.createdAt, order: .reverse)
    private var savedPresets: [CategoryPreset]

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                presetList
                Spacer()
                continueButton
            }
            .navigationTitle("Category Preset")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                navigationToolbar
            }
            .sheet(isPresented: $isShowingSheet) {
                CategorySelectView(preset: presetToEdit)
            }
        }
    }
}

// MARK: - View Components
extension CategoryPresetView {
    @ViewBuilder
    fileprivate var presetList: some View {
        if savedPresets.isEmpty {
            ContentUnavailableView(
                "No Presets",
                systemImage: "tray",
                description: Text("Tap + to create a new category preset.")
            )
        } else {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(savedPresets) { preset in
                        CategoryPresetCard(
                            preset: preset,
                            isSelected: selectedPreset == preset.id,
                            onEdit: {
                                presetToEdit = preset
                                isShowingSheet = true
                            }
                        )
                        .onTapGesture {
                            selectedPreset = preset.id
                        }
                    }
                }
                .padding()
            }
        }
    }

    fileprivate var continueButton: some View {
        NavigationLink {
            PriorityPresetView()
        } label: {
            Text("Continue")
        }
        .buttonStyle(.borderedProminent)
        .disabled(selectedPreset == nil)
    }

    fileprivate var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    presetToEdit = nil
                    isShowingSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let container: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)

        let container = try! ModelContainer(
            for: Category.self, CategoryPreset.self, configurations: config)

        let context = container.mainContext

        for category in SeedData.categoryData {
            context.insert(category)
        }

        let selectedCategories = Array(SeedData.categories.prefix(3))

        let dummyPreset = CategoryPreset(
            title: "Weekend Getaway",
            desc: "Essential categories for a short 3-day trip to Singapore.",
            categories: selectedCategories
        )
        context.insert(dummyPreset)

        return container
    }()

    CategoryPresetView()
        .modelContainer(container)
}
