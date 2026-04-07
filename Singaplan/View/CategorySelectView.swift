//
//  CategoryCreate.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct CategorySelectView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: CategoryViewModel
    @State private var isShowingSaveModal = false
    
    init(modelContext: ModelContext) {
        self._viewModel = State(initialValue: CategoryViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                SearchBar(text: $viewModel.searchText, placeholder: "Search categories...")
                    .padding(.vertical)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(viewModel.filteredCategories) { parent in
                            VStack(alignment: .leading, spacing: 12) {
                                Text(parent.title)
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                FlowLayout() {
                                    ForEach(parent.subCategories) { child in
                                        CategoryCapsule(
                                            child: child,
                                            isSelected: viewModel.selectedCategories.contains(child),
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
                .navigationTitle("Select Categories")
                .navigationBarTitleDisplayMode(.inline)
                
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            isShowingSaveModal = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $isShowingSaveModal) {
                    CategorySaveView(selectedCategories: Array(viewModel.selectedCategories))
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
    return CategorySelectView(modelContext: context)
        .modelContainer(container)
}
