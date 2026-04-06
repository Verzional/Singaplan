//
//  CategoryCreate.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI

struct CategoryCreateView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategories: Set<CategoryModel> = []
    
    var body: some View {
        NavigationStack{
            Text("Hello World")
        }
        .navigationTitle("Select Categories")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(.black)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    dismiss()
                }
                .disabled(selectedCategories.isEmpty)
            }
        }
    }
}

#Preview {
    CategoryCreateView()
}
