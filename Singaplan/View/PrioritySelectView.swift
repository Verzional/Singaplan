//
//  PrioritySelectView.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftData
import SwiftUI

struct PrioritySelectView: View {
    // MARK: - File Properties
    @Environment(\.dismiss) private var dismiss

    // ViewModel
    @State private var viewModel: PriorityViewModel

    // State Properties
    @State private var isShowingModal = false
    @State private var budgetExpanded = false
    @State private var experienceExpanded = false
    @State private var accessibilityExpanded = false

    // Local Variables
    let priceBracket = ["$", "$$", "$$$"]
    private let presetToEdit: PriorityPreset?

    init(modelContext: ModelContext, preset: PriorityPreset? = nil) {
        self.presetToEdit = preset
        self._viewModel = State(
            initialValue: PriorityViewModel(
                modelContext: modelContext,
                preset: preset
            )
        )
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                budgetSection
                experienceSection
                accessibilitySection
            }
            .navigationTitle(presetToEdit == nil ? "Priority" : "Edit Priority")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                navigationToolbar
            }
            .sheet(isPresented: $isShowingModal) {
                PrioritySaveView(
                    preset: presetToEdit,
                    priorities: viewModel.allPriorities,
                    onSaveComplete: { dismiss() }
                )
            }
        }
    }
}

// MARK: - View Components
private extension PrioritySelectView {
    var budgetSection: some View {
        DisclosureGroup("Budget", isExpanded: $budgetExpanded) {
            VStack(alignment: .leading, spacing: 24) {
                // Price Bracket
                VStack(alignment: .leading) {
                    Text("Price Bracket")
                        .font(.subheadline)

                    Picker("Price Range", selection: $viewModel.selectedBracket) {
                        ForEach(priceBracket, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }

                // Additional Fees
                VStack(alignment: .leading) {
                    Text("Additional Fees")
                        .font(.subheadline)

                    Picker("Fee Range", selection: $viewModel.entryFee) {
                        Text("Include Fees").tag(true)
                        Text("No Fees Only").tag(false)
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .font(.headline)
    }

    var experienceSection: some View {
        DisclosureGroup("Experience", isExpanded: $experienceExpanded) {
            segmentSection(for: $viewModel.experiences)
        }
        .font(.headline)
    }

    var accessibilitySection: some View {
        DisclosureGroup("Accessibility", isExpanded: $accessibilityExpanded) {
            segmentSection(for: $viewModel.accessibility)
        }
        .font(.headline)
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
                    isShowingModal = true
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
        }
    }

    // MARK: - Section Component
    @ViewBuilder
    func segmentSection(for data: Binding<[PriorityModel]>) -> some View {
        ForEach(data) { $item in
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.subheadline)

                Text(item.desc)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Picker("Experience Level", selection: $item.selectedWeight) {
                    ForEach(item.segments, id: \.weight) { segment in
                        Text(segment.label).tag(segment.weight)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom, 8)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    // In Memory DB
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: PriorityPreset.self, PriorityModel.self, configurations: config)

    // Return Preview
    return PrioritySelectView(modelContext: container.mainContext)
        .modelContainer(container)
}
