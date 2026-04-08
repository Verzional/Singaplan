//
//  CategoryPreset.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct CategoryPresetView: View {
    // MARK: - File Properties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // State Properties
    @State private var presetToEdit: CategoryPreset?
    @State private var selectedPreset: UUID?
    @State private var isShowingSheet = false
    
    // Data Query
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
                CategorySelectView(modelContext: modelContext, preset: presetToEdit)
            }
        }
    }
}

// MARK: - Card Component
struct PresetCard: View {
    let preset: CategoryPreset
    let isSelected: Bool
    let onEdit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                // Title and Description
                VStack(alignment: .leading, spacing: 8) {
                    Text(preset.title)
                        .font(.title3)
                        .bold()
                    if let desc = preset.desc {
                        Text(desc)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
                
                // Edit Button
                Button(action: onEdit) {
                    Image(systemName: "pencil")
                        .font(.system(size: 16, weight: .medium))
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Circle())
                }
                .contentShape(Circle())
            }
            
            // Category Capsules
            FlowLayout(spacing: 8) {
                ForEach(preset.categories) { category in
                    CategoryCapsule(child: category, isSelected: true)
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .overlay {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue, lineWidth: 2)
                    }
                }
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
        }
        .animation(.snappy, value: isSelected)
    }
}

// MARK: - View Components
private extension CategoryPresetView {
    @ViewBuilder
    var presetList: some View {
        if savedPresets.isEmpty {
            ContentUnavailableView(
                "No Presets", systemImage: "tray",
                description: Text("Tap + to create a new category preset.")
            )
        } else {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(savedPresets) { preset in
                        PresetCard(
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
    
    var continueButton: some View {
        NavigationLink {
            PriorityPresetView()
        } label: {
            Text("Continue")
        }
        .buttonStyle(.borderedProminent)
        .disabled(selectedPreset == nil)
    }
    
    var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
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
            for: CategoryModel.self, CategoryPreset.self, configurations: config)
        
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
