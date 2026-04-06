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
    @Environment(\.modelContext) private var modelContext
    
    @State private var viewModel: CategoryViewModel
    
    init(modelContext: ModelContext) {
        self._viewModel = State(initialValue: CategoryViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    ForEach(viewModel.mainCategories) { parent in
                        VStack(alignment: .leading) {
                            Text(parent.title).font(.headline).padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(parent.subCategories) { child in
                                        CategoryCapsule(
                                            child: child,
                                            isSelected: viewModel.selectedCategories.contains(child)
                                        )
                                        .onTapGesture {
                                            viewModel.toggle(child)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
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
                    .disabled(viewModel.selectedCategories.isEmpty)
                }
            }
        }
    }
}

#Preview {
    // In Memory DB
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: CategoryModel.self, configurations: config)
    
    // Context
    let context = container.mainContext
    
    // Data Injection
    for category in SeedData.categoryData {
        context.insert(category)
    }
    
    // Return Preview
    return CategoryCreateView(modelContext: context)
        .modelContainer(container)
}
