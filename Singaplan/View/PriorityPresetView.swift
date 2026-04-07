//
//  PriorityPreset.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct PriorityPresetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var presetToEdit: PriorityPreset?
    @State private var isShowingSheet = false

    @Query(sort: \PriorityPreset.createdAt, order: .reverse)
    private var savedPresets: [PriorityPreset]
    
    var body: some View {
        NavigationStack {
            VStack {
                if savedPresets.isEmpty {
                    ContentUnavailableView(
                        "No Presets", systemImage: "tray",
                        description: Text("Tap + to create a new priority preset."))
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(savedPresets) { preset in
//                                presetCard(preset)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Priority Preset")
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
                        presetToEdit = nil
                        isShowingSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingSheet) {
                PrioritySelectView()
            }
        }
    }
}

#Preview {
    PriorityPresetView()
}
