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
            
            // Category Capsules
            FlowLayout(spacing: 8) {
                ForEach(preset.priorities) { priority in
//                    CategoryCapsule(child: category, isSelected: true)
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
