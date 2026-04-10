//
//  PrioritySaveView.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 07/04/26.
//

import SwiftData
import SwiftUI

struct PrioritySaveView: View {
    //MARK: - File Properties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    // State Properties
    @State private var presetTitle: String = ""
    @State private var presetDescription: String = ""

    // Local Variables
    let priorities: [Priority]
    let presetToEdit: PriorityPreset?
    let onSaveComplete: () -> Void

    init(
        preset: PriorityPreset? = nil, priorities: [Priority],
        onSaveComplete: @escaping () -> Void
    ) {
        self.presetToEdit = preset
        self.priorities = priorities
        self.onSaveComplete = onSaveComplete

        self._presetTitle = State(initialValue: preset?.title ?? "")
        self._presetDescription = State(initialValue: preset?.desc ?? "")
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                detailsSection
                prioritiesSection
            }
            .navigationTitle(presetToEdit == nil ? "Save Preset" : "Edit Preset")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                navigationToolbar
            }
        }
    }
}

// MARK: - View Components
private extension PrioritySaveView {
    var detailsSection: some View {
        Section("Preset Details") {
            TextField("Name (e.g., Budget Oriented)", text: $presetTitle)
            TextField("Description", text: $presetDescription, axis: .vertical)
                .lineLimit(3...5)
        }
    }

    var prioritiesSection: some View {
        Section("Selected Priorities") {
            FlowLayout {
                ForEach(priorities) { priority in
                    PriorityCapsule(child: priority)
                }
            }
            .padding(.vertical, 8)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
        }
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
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    savePreset()
                } label: {
                    Image(systemName: "checkmark")
                }
                .disabled(presetTitle.isEmpty)
            }
        }
    }

    func savePreset() {
        if let existingPreset = presetToEdit {
            let oldPriorities = existingPreset.priorities

            for priority in priorities {
                modelContext.insert(priority)
            }

            existingPreset.title = presetTitle
            existingPreset.desc = presetDescription.isEmpty ? nil : presetDescription
            existingPreset.priorities = priorities

            for old in oldPriorities {
                modelContext.delete(old)
            }
        } else {
            for priority in priorities {
                modelContext.insert(priority)
            }

            let newPreset = PriorityPreset(
                title: presetTitle,
                desc: presetDescription.isEmpty ? nil : presetDescription,
                priorities: priorities
            )
            modelContext.insert(newPreset)
        }

        dismiss()
        onSaveComplete()
    }
}

// MARK: - Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: PriorityPreset.self, Priority.self, configurations: config)

    let samplePriorities = [
        Priority(
            title: "Popularity",
            desc:
                "Balance your trip between world-renowned icons and under-the-radar local secrets.",
            segments: [
                PrioritySegment(label: "Hidden Gems", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "Iconic Hits", weight: 1.0),
            ]
        ),
        Priority(
            title: "Mobility",
            desc:
                "Prioritize level, easy-access paths or embrace more rugged, adventurous surfaces.",
            segments: [
                PrioritySegment(label: "Rugged", weight: 0.1),
                PrioritySegment(label: "Standard", weight: 0.5),
                PrioritySegment(label: "Seamless", weight: 1.0),
            ]
        ),
        Priority(
            title: "Walkability",
            desc:
                "Balance your trip between vehicle-heavy roads and pedestrian-first zones with tram lines.",
            segments: [
                PrioritySegment(label: "Vehicle", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "Pedestrian", weight: 1.0),
            ]
        ),
    ]

    NavigationStack {
        PrioritySaveView(
            preset: nil,
            priorities: samplePriorities,
            onSaveComplete: {}
        )
    }
    .modelContainer(container)
}
