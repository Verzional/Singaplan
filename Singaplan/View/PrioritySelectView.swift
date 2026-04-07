//
//  PrioritySelectView.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct PrioritySelectView: View {
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - State Properties
    @State private var isShowingModal = false
    @State private var budgetExpanded = false
    @State private var experienceExpanded = false
    @State private var accessibilityExpanded = false
    
    // Budget Selector States
    @State private var selectedBracket = "$$"
    @State private var entryFee = false

    let priceBracket = ["$", "$$", "$$$"]
    
    private var presetToEdit: PriorityPreset?
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                budgetSection
                experienceSection
                accessibilitySection
            }
            .navigationTitle("Priority")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                navigationToolbar
            }
            .sheet(isPresented: $isShowingModal) {
                PrioritySaveView()
            }
        }
    }
}

// MARK: - View Components
private extension PrioritySelectView {
    var budgetSection: some View {
        DisclosureGroup("Budget", isExpanded: $budgetExpanded) {
            VStack (alignment: .leading, spacing: 16) {
                // Price Bracket
                VStack(alignment: .leading) {
                    Text("Price Bracket")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Picker("Price Range", selection: $selectedBracket) {
                        ForEach(priceBracket, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }
                
                // Additional Fees
                VStack(alignment: .leading) {
                    Text("Additional Fees")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Picker("Fee Range", selection: $entryFee) {
                        Text("Include Fees").tag(true)
                        Text("No Fees Only").tag(false)
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .font(.headline)
    }
    
    var experienceSection: some View {
        DisclosureGroup("Experience", isExpanded: $experienceExpanded) {
            // Content
        }
        .font(.headline)
    }
    
    var accessibilitySection: some View {
        DisclosureGroup("Accessibility", isExpanded: $accessibilityExpanded) {
            // Content
        }
        .font(.headline)
    }
    
    var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isShowingModal = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    PrioritySelectView()
}
