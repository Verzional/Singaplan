//
//  CategoryCreate.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct CategoryCreateView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategories: Set<CategoryModel> = []
    
    
    var body: some View {
        NavigationStack{
            ScrollView {
                // Stack
                LazyVStack(alignment: .leading, spacing: 30) {
                    // Loop
                    ForEach(mainCategories) { parent in
                        VStack(alignment: .leading, spacing: 12) {
                            
                            // A. Parent Title
                            Text(parent.title)
                                .font(.headline)
                                .padding(.horizontal)
                            
                            // B. Horizontal Scroll of Child Capsules
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(parent.subCategories) { child in
                                        CategoryCapsule(
                                            child: child,
                                            isSelected: selectedCategories.contains(child)
                                        )
                                        .onTapGesture {
                                            toggle(child)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Select Categories")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button() {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button() {
                        dismiss()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.blue)
                    }
                    .disabled(selectedCategories.isEmpty)
                }
            }
        }
    }
    
    private func toggle(_ category: CategoryModel) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}

#Preview {
    CategoryCreateView()
}
