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
    
    // Priority Selector States
    @State private var experiences = SeedData.experiences
    @State private var accessibility = SeedData.accessibility
    
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
            VStack (alignment: .leading, spacing: 24) {
                // Price Bracket
                VStack(alignment: .leading) {
                    Text("Price Bracket")
                        .font(.subheadline)
                    
                    Picker("Price Range", selection: $selectedBracket) {
                        ForEach(priceBracket, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }
                
                // Additional Fees
                VStack(alignment: .leading) {
                    Text("Additional Fees")
                        .font(.subheadline)
                    
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
            segmentSection(for: $experiences)
        }
        .font(.headline)
    }
    
    var accessibilitySection: some View {
        DisclosureGroup("Accessibility", isExpanded: $accessibilityExpanded) {
            segmentSection(for: $accessibility)
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

// MARK: - Section Component
@ViewBuilder
private func segmentSection(for data: Binding<[PriorityModel]>) -> some View {
    ForEach(data) { $item in
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.subheadline)
            
            Text(item.desc)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Picker("Experience Level", selection: $item.selectedWeight) {
                ForEach(item.segments, id: \.weight) { segment in
                    Text(segment.label).tag(segment.weight)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 8)
        }
    }
}

#Preview {
    PrioritySelectView()
}
