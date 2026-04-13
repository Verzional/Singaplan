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

    // State Properties
    @State private var experiences: [Priority]
    @State private var accessibility: [Priority]
    @State private var selectedBracket: String = "$$"
    @State private var entryFee: Bool = false
    @State private var isShowingModal = false
    @State private var budgetExpanded = false
    @State private var experienceExpanded = false
    @State private var accessibilityExpanded = false

    // Local Variables
    let priceBracket = ["$", "$$", "$$$"]
    private let presetToEdit: PriorityPreset?

    // Computed
    var allPriorities: [Priority] {
        experiences + accessibility
    }

    init(preset: PriorityPreset? = nil) {
        self.presetToEdit = preset

        if let preset = preset {
            let expTitles = SeedData.experiences.map(\.title)
            let accTitles = SeedData.accessibility.map(\.title)

            let presetByTitle = Dictionary(
                uniqueKeysWithValues: preset.priorities.map { ($0.title, $0) }
            )

            var exps = expTitles.compactMap { title -> Priority? in
                guard let source = presetByTitle[title] else { return nil }
                return PrioritySelectView.makeCopy(of: source)
            }

            var accs = accTitles.compactMap { title -> Priority? in
                guard let source = presetByTitle[title] else { return nil }
                return PrioritySelectView.makeCopy(of: source)
            }

            if exps.isEmpty { exps = PrioritySelectView.freshCopies(of: SeedData.experiences) }
            if accs.isEmpty { accs = PrioritySelectView.freshCopies(of: SeedData.accessibility) }

            self._experiences = State(initialValue: exps)
            self._accessibility = State(initialValue: accs)
        } else {
            self._experiences = State(
                initialValue: PrioritySelectView.freshCopies(of: SeedData.experiences))
            self._accessibility = State(
                initialValue: PrioritySelectView.freshCopies(of: SeedData.accessibility))
        }
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
                    priorities: allPriorities,
                    onSaveComplete: { dismiss() }
                )
            }
        }
    }
}

// MARK: - View Functions
extension PrioritySelectView {
    fileprivate static func makeCopy(of source: Priority) -> Priority {
        let copy = Priority(
            title: source.title,
            desc: source.desc,
            segments: source.segments
        )
        copy.selectedWeight = source.selectedWeight
        return copy
    }

    fileprivate static func freshCopies(of templates: [Priority]) -> [Priority] {
        templates.map { source in
            Priority(
                title: source.title,
                desc: source.desc,
                segments: source.segments
            )
        }
    }
}

// MARK: - View Components
extension PrioritySelectView {
    fileprivate var budgetSection: some View {
        DisclosureGroup("Budget", isExpanded: $budgetExpanded) {
            VStack(alignment: .leading, spacing: 24) {
                // Price Bracket
                VStack(alignment: .leading) {
                    Text("Price Bracket")
                        .font(.subheadline)

                    Picker("Price Range", selection: $selectedBracket) {
                        ForEach(priceBracket, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }

                // Additional Fees
                VStack(alignment: .leading) {
                    Text("Additional Fees")
                        .font(.subheadline)

                    Picker("Fee Range", selection: $entryFee) {
                        Text("Include Fees").tag(true)
                        Text("No Fees Only").tag(false)
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .font(.headline)
    }

    fileprivate var experienceSection: some View {
        DisclosureGroup("Experience", isExpanded: $experienceExpanded) {
            segmentSection(for: $experiences)
        }
        .font(.headline)
    }

    fileprivate var accessibilitySection: some View {
        DisclosureGroup("Accessibility", isExpanded: $accessibilityExpanded) {
            segmentSection(for: $accessibility)
        }
        .font(.headline)
    }

    fileprivate var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Next") {
                    isShowingModal = true
                }
            }
        }
    }

    @ViewBuilder
    fileprivate func segmentSection(for data: Binding<[Priority]>) -> some View {
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: PriorityPreset.self, Priority.self, configurations: config)

    return PrioritySelectView()
        .modelContainer(container)
}
