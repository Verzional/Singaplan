//
//  CategoryPresetCard.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 09/04/26.
//

import SwiftUI

struct CategoryPresetCard: View {
    let preset: CategoryPreset
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
            
            // Category Capsules
            categoryCapsules
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

// MARK: - View Components
private extension CategoryPresetCard {
    private var categoryCapsules: some View {
        let categories = preset.categories
        let visible = categories.prefix(4)
        let extraCount = max(categories.count - visible.count, 0)
        
        return FlowLayout {
            ForEach(Array(visible)) { category in
                CategoryCapsule(child: category, isSelected: false)
            }
            
            if extraCount > 0 {
                HStack(spacing: 4) {
                    Text("+ \(extraCount)")
                }
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.blue)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule().fill(Color.blue.opacity(0.12))
                )
                .padding(.top, 2)
            }
        }
    }
}

// MARK: - Preview
#Preview("Category Preset Card") {
    // Mock categories
    let categories: [Category] = [
        Category(title: "Nature", icon: "leaf.fill"),
        Category(title: "Food", icon: "fork.knife.circle.fill"),
        Category(title: "Family", icon: "figure.2.and.child.holdinghands"),
        Category(title: "Nightlife", icon: "moon.stars.fill"),
        Category(title: "Scenic", icon: "camera.fill")
    ]

    // Mock preset
    let preset = CategoryPreset(
        title: "Weekend Getaway",
        desc: "A relaxed mix for a short trip.",
        categories: categories
    )

    VStack(spacing: 20) {
        CategoryPresetCard(
            preset: preset,
            isSelected: false,
            onEdit: { print("Edit tapped (unselected)") }
        )

        CategoryPresetCard(
            preset: preset,
            isSelected: true,
            onEdit: { print("Edit tapped (selected)") }
        )
    }
    .padding()
}
