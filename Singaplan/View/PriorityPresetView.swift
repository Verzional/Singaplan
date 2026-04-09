//
//  PriorityPreset.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

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
                PrioritySelectView()
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
                        // presetCard(preset)
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
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
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
    PriorityPresetView()
}
