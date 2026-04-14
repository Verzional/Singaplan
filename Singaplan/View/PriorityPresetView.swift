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
    @Environment(\.dismiss) private var dismiss
    @Environment(FlowManager.self) private var flowManager
    
    @State private var presetToEdit: PriorityPreset?
    @State private var selectedPreset: UUID?
    @State private var isShowingSheet = false
    
    @Query(sort: \PriorityPreset.createdAt, order: .reverse)
    private var savedPresets: [PriorityPreset]
    
    // MARK: - Body
    var body: some View {
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
            PrioritySelectView(preset: presetToEdit)
        }
    }
}

// MARK: - View Components
extension PriorityPresetView {
    @ViewBuilder
    fileprivate var presetList: some View {
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
                            flowManager.selectedPriorityPreset = preset
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    fileprivate var continueButton: some View {
        Button("Continue") {
            flowManager.navigationPath.append(DiscoverRoute.recommendedDistricts)
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
//#Preview {
//    let container: ModelContainer = {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//
//        let container = try! ModelContainer(
//            for: PriorityPreset.self, Priority.self, configurations: config)
//
//        let context = container.mainContext
//
//        for priority in SeedData.priorityData {
//            context.insert(priority)
//        }
//
//        let selectedPriorities = Array(SeedData.priorityData.prefix(3))
//
//        let dummyPreset = PriorityPreset(
//            title: "Budget Oriented",
//            desc: "Essential items only",
//            priorities: selectedPriorities
//        )
//        context.insert(dummyPreset)
//
//        return container
//    }()
//
//    PriorityPresetView()
//        .modelContainer(container)
//}
