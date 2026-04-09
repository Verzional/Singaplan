//
//  PriorityPresetView.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftData
import SwiftUI

struct PriorityPresetView: View {
    // MARK: - File Properties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    // State Properties
    @State private var presetToEdit: PriorityPreset?
    @State private var selectedPreset: UUID?
    @State private var isShowingSheet = false

    // Data Query
    @Query(sort: \PriorityPreset.createdAt, order: .reverse)
    private var savedPresets: [PriorityPreset]

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                presetList
                Spacer()
                continueButton
            }
            .navigationTitle("Priority Preset")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                navigationToolbar
            }
            .sheet(isPresented: $isShowingSheet) {
                PrioritySelectView(modelContext: modelContext, preset: presetToEdit)
            }
        }
    }
}

// MARK: - View Components
private extension PriorityPresetView {
    @ViewBuilder
    var presetList: some View {
        if savedPresets.isEmpty {
            ContentUnavailableView(
                "No Presets", systemImage: "tray",
                description: Text("Tap + to create a new priority preset."))
        } else {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(savedPresets) { preset in
                        PriorityPresetCard(
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
            RecommendedDistricts()
        } label: {
            Text("Continue")
        }
        .buttonStyle(.borderedProminent)
        .disabled(selectedPreset == nil)
    }

    var navigationToolbar: some ToolbarContent {
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
            for: PriorityPreset.self, PriorityModel.self, configurations: config)

        let context = container.mainContext

        for priority in SeedData.priorityData {
            context.insert(priority)
        }

        let selectedPriorities = Array(SeedData.priorityData.prefix(3))

        let dummyPreset = PriorityPreset(
            title: "Budget Oriented",
            desc: "Essential items only",
            priorities: selectedPriorities
        )
        context.insert(dummyPreset)

        return container
    }()

    PriorityPresetView()
        .modelContainer(container)
}
