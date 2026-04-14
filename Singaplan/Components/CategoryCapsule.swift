//
//  CategoryCapsule.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI

struct CategoryCapsule: View {
    let child: Category
    let isSelected: Bool

    var body: some View {
        // Main Stack
        HStack(spacing: 8) {
            // Icon
            Image(systemName: child.icon ?? "questionmark")
                .font(.system(size: 14, weight: .medium))

            // Title
            Text(child.title)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)

        // Styling
        .background(isSelected ? Color.blue : Color(.systemGray6))
        .foregroundStyle(isSelected ? .white : .primary)
        .overlay(
            Capsule()
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 1)
        )
        .clipShape(Capsule())
        .animation(.spring(duration: 0.2), value: isSelected)
    }
}

#Preview {
    CategoryCapsule(child: Category(title: "Mountain", icon: "mountain.2"), isSelected: false)
}
