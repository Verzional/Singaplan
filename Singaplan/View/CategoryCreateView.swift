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
    @Query(filter: #Predicate<CategoryModel> { $0.parent == nil }, sort: \.title)
    private var mainCategories: [CategoryModel]
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Hello World")
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
}

#Preview {
    CategoryCreateView()
}
