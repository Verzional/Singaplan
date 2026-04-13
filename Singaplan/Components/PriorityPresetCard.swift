//
//  PriorityPresetCard.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 09/04/26.
//

import SwiftUI

struct PriorityPresetCard: View {
    let preset: PriorityPreset
    let isSelected: Bool
    let onEdit: () -> Void
    
    // MARK: - Body
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
            
            // Priority Capsules
            FlowLayout(spacing: 8) {
                ForEach(preset.priorities) { priority in
                    PriorityCapsule(child: priority)
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

// MARK: - Preview
#Preview("Priority Preset Card") {
    let mockPriorities: [Priority] = [
        Priority(
            title: "Budget",
            desc: "Overall cost",
            segments: [
                PrioritySegment(label: "$", weight: 0.1),
                PrioritySegment(label: "$$", weight: 0.5),
                PrioritySegment(label: "$$$", weight: 1.0)
            ]
        ),
        Priority(
            title: "Popularity",
            desc: "How popular it is",
            segments: [
                PrioritySegment(label: "Low", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "High", weight: 1.0)
            ]
        ),
        Priority(
            title: "Pace",
            desc: "Activity speed",
            segments: [
                PrioritySegment(label: "Relaxed", weight: 0.1),
                PrioritySegment(label: "Balanced", weight: 0.5),
                PrioritySegment(label: "Fast", weight: 1.0)
            ]
        ),
        Priority(
            title: "Mobility",
            desc: "Accessibility needs",
            segments: [
                PrioritySegment(label: "Wheelchair", weight: 0.1),
                PrioritySegment(label: "Some stairs", weight: 0.5),
                PrioritySegment(label: "Stairs OK", weight: 1.0)
            ]
        ),
        Priority(
            title: "Proximity",
            desc: "Location to destination",
            segments: [
                PrioritySegment(label: "Wheelchair", weight: 0.1),
                PrioritySegment(label: "Some stairs", weight: 0.5),
                PrioritySegment(label: "Stairs OK", weight: 1.0)
            ]
            )
    ]

    let mockPreset = PriorityPreset(
        title: "Balanced Day",
        desc: "A good mix for most travelers.",
        priorities: mockPriorities
    )

    return VStack(spacing: 20) {
        PriorityPresetCard(
            preset: mockPreset,
            isSelected: false,
            onEdit: { print("Edit tapped (unselected)") }
        )

        PriorityPresetCard(
            preset: mockPreset,
            isSelected: true,
            onEdit: { print("Edit tapped (selected)") }
        )
    }
    .padding()
}

