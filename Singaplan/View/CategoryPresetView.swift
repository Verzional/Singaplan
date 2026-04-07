//
//  CategoryPreset.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct CategoryPresetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var isShowingCreateModal = false
    
    @Query(sort: \CategoryPreset.createdAt, order: .reverse)
    private var savedPresets: [CategoryPreset]
    
    var body: some View {
        NavigationStack {
            Group {
                if savedPresets.isEmpty {
                    ContentUnavailableView("No Presets", systemImage: "tray", description: Text("Tap + to create a new category preset."))
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(savedPresets) { preset in
                                presetCard(preset)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Category Preset")
            .navigationBarTitleDisplayMode(.inline)
            
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
                        isShowingCreateModal = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingCreateModal) {
                CategorySelectView(modelContext: modelContext)
            }
        }
    }
    
    @ViewBuilder
    private func presetCard(_ preset: CategoryPreset) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
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
                
                Button {
                    // Action for editing
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.blue)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            
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
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
    }
}

#Preview {
    let container: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        let container = try! ModelContainer(for: CategoryModel.self, CategoryPreset.self, configurations: config)
        
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
