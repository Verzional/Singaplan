//
//  PriorityCapsule.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 09/04/26.
//

import SwiftUI

struct PriorityCapsule: View {
    let child: PriorityModel
    
    var selectedLabel: String {
        child.segments.first(where: { $0.weight == child.selectedWeight })?.label ?? "Unknown"
    }
    
    var body: some View {
        // Main Stack
        HStack(spacing: 8) {
            // Title
            Text(child.title)
                .font(.subheadline)
                .fontWeight(.medium)
            // Weight
            Text(selectedLabel)
                .font(.caption)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.blue.opacity(0.1))
                .foregroundStyle(.blue)
                .clipShape(Capsule())
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        
        // Styling
        .background(Color(.systemGray6))
        .foregroundStyle(.primary)
        .overlay(
            Capsule()
                .stroke(Color.clear, lineWidth: 1)
        )
        .clipShape(Capsule())
    }
}

#Preview {
    PriorityCapsule(child: PriorityModel(
        title: "Popularity",
        desc: "Balance your trip between world-renowned icons and under-the-radar local secrets.",
        segments: [
            PrioritySegment(label: "Hidden Gems", weight: 0.1),
            PrioritySegment(label: "Mixed", weight: 0.5),
            PrioritySegment(label: "Iconic Hits", weight: 1.0)
        ]
    ))
}
